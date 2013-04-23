From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH v5] git-completion.bash: add support for path completion
Date: Tue, 23 Apr 2013 17:25:24 +0200
Message-ID: <5176A7E4.2070608@gmail.com>
References: <1357930123-26310-1-git-send-email-manlio.perillo@gmail.com> <CAMP44s1TjTiZ9HsXn9YiJ8E6+jC=s+g_tps6AY2ixrrgX=0jnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, szeder@ira.uka.de,
	peff@peff.net
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 17:26:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUf7N-0004NJ-3a
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 17:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826Ab3DWP0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 11:26:49 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:41031 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756259Ab3DWP0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 11:26:48 -0400
Received: by mail-ee0-f45.google.com with SMTP id l10so335855eei.32
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=Hr9s2XxwHinGJVtpkfS2HMskmkaZ8j8SvtPZIC0EphE=;
        b=LJkbG6vFK8rX0w/ymV66wyGem/jPklIUO/GINOD+Us+qC5jqI5ypNENnlc8pZJPY+P
         4T9z5fZ4ERIUPWdw3ojSrQhfwA+OEbf/tMtND/WxKh9rHWPf9teVbRj52p2RgHOinctK
         sl8tlV0E+16va/yXA56oUnAjO1OqN0I6FgvoqbEo5zK3haRh+x85weJHy+SN/8dWxO+t
         BoPsMKIli9fSWwwTkqmS+LMFanty/oO5ZBrS2yTi+lCrXrR/KoYHfBYsDVVNgF6hYn5N
         n6d21D8ZE7+daorpc8Idrqu/Pihf7/Mo1d3oZLbXDXaI01yuhUgPhX+OpcWZqURQEplr
         G3gw==
X-Received: by 10.14.5.72 with SMTP id 48mr52191204eek.19.1366730806627;
        Tue, 23 Apr 2013 08:26:46 -0700 (PDT)
Received: from [192.168.0.3] ([151.70.212.83])
        by mx.google.com with ESMTPS id j43sm13050492eep.4.2013.04.23.08.26.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 08:26:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <CAMP44s1TjTiZ9HsXn9YiJ8E6+jC=s+g_tps6AY2ixrrgX=0jnw@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222180>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 21/04/2013 12:14, Felipe Contreras ha scritto:
> On Fri, Jan 11, 2013 at 12:48 PM, Manlio Perillo
> <manlio.perillo@gmail.com> wrote:
>> The git-completion.bash script did not implemented full, git aware,
>> support to complete paths, for git commands that operate on files within
>> the current working directory or the index.
> 
>> +__git_index_file_list_filter_compat ()
>> +{
>> +       local path
>> +
>> +       while read -r path; do
>> +               case "$path" in
>> +               ?*/*) echo "${path%%/*}/" ;;
>> +               *) echo "$path" ;;
>> +               esac
>> +       done
>> +}
>> +
>> +__git_index_file_list_filter_bash ()
>> +{
>> +       local path
>> +
>> +       while read -r path; do
>> +               case "$path" in
>> +               ?*/*)
>> +                       # XXX if we append a slash to directory names when using
>> +                       # `compopt -o filenames`, Bash will append another slash.
>> +                       # This is pretty stupid, and this the reason why we have to
>> +                       # define a compatible version for this function.
>> +                       echo "${path%%/*}" ;;
> 
> Which version of bash is that? It works perfectly fine here with or
> without the /.
> 

GNU bash, version 4.1.5(1)-release (i486-pc-linux-gnu)
on a GNU Linux Debian 6

>> +# __git_index_files accepts 1 or 2 arguments:
>> +# 1: Options to pass to ls-files (required).
>> +#    Supported options are --cached, --modified, --deleted, --others,
>> +#    and --directory.
>> +# 2: A directory path (optional).
>> +#    If provided, only files within the specified directory are listed.
>> +#    Sub directories are never recursed.  Path must have a trailing
>> +#    slash.
>> +__git_index_files ()
>> +{
>> +       local dir="$(__gitdir)" root="${2-.}"
>> +
>> +       if [ -d "$dir" ]; then
>> +               __git_ls_files_helper "$root" "$1" | __git_index_file_list_filter |
>> +                       sort | uniq
>> +       fi
>> +}
>> +
>> +# __git_diff_index_files accepts 1 or 2 arguments:
>> +# 1) The id of a tree object.
>> +# 2) A directory path (optional).
>> +#    If provided, only files within the specified directory are listed.
>> +#    Sub directories are never recursed.  Path must have a trailing
>> +#    slash.
>> +__git_diff_index_files ()
>> +{
>> +       local dir="$(__gitdir)" root="${2-.}"
>> +
>> +       if [ -d "$dir" ]; then
>> +               __git_diff_index_helper "$root" "$1" | __git_index_file_list_filter |
>> +                       sort | uniq
>> +       fi
>> +}
> 
> These two are exactly the same, except one calls
> __git_ls_files_helper, and the other one __git_diff_index_helper,
> can't we make another argument that is and select one or the other
> based on that?
> 

They are not exactly the same.

The first function requires, as first parameter, (space separed) options
to pass to ls-files command; the second function, instead, requires the
id of a tree object.

IMHO, using only one function may be confusing.

>>  __git_heads ()
>>  {
>>         local dir="$(__gitdir)"
>> @@ -430,6 +543,46 @@ __git_complete_revlist_file ()
>>  }
>>
>>
>> +# __git_complete_index_file requires 1 argument: the options to pass to
>> +# ls-file
>> +__git_complete_index_file ()
>> +{
>> +       local pfx cur_="$cur"
>> +
>> +       case "$cur_" in
>> +       ?*/*)
>> +               pfx="${cur_%/*}"
>> +               cur_="${cur_##*/}"
>> +               pfx="${pfx}/"
>> +
>> +               __gitcomp_file "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_"
>> +               ;;
>> +       *)
>> +               __gitcomp_file "$(__git_index_files "$1")" "" "$cur_"
>> +               ;;
>> +       esac
>> +}
>> +
>> +# __git_complete_diff_index_file requires 1 argument: the id of a tree
>> +# object
>> +__git_complete_diff_index_file ()
>> +{
>> +       local pfx cur_="$cur"
>> +
>> +       case "$cur_" in
>> +       ?*/*)
>> +               pfx="${cur_%/*}"
>> +               cur_="${cur_##*/}"
>> +               pfx="${pfx}/"
>> +
>> +               __gitcomp_file "$(__git_diff_index_files "$1" "$pfx")" "$pfx" "$cur_"
>> +               ;;
>> +       *)
>> +               __gitcomp_file "$(__git_diff_index_files "$1")" "" "$cur_"
>> +               ;;
>> +       esac
>> +}
> 
> These are also exactly the same, we could pass the argument to the
> function above.
> 

See previous note.



Regards  Manlio Perillo
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlF2p+QACgkQscQJ24LbaUQVcACfeYFO8umJDbgTrXWChqqbk69E
CE4AniZFP7PQkOZCbBY+6hZ2gMpNIJTn
=HqAf
-----END PGP SIGNATURE-----
