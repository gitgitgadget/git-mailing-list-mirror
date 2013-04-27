From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5] git-completion.bash: add support for path completion
Date: Fri, 26 Apr 2013 21:52:07 -0500
Message-ID: <CAMP44s30zWa6qU9CPJ4eL5KHZ0kST7UL8y6Xk_Yqk00-Gr2AqQ@mail.gmail.com>
References: <1357930123-26310-1-git-send-email-manlio.perillo@gmail.com>
	<CAMP44s1TjTiZ9HsXn9YiJ8E6+jC=s+g_tps6AY2ixrrgX=0jnw@mail.gmail.com>
	<5176A7E4.2070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, szeder@ira.uka.de,
	peff@peff.net
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 04:52:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVvFG-00035j-Kf
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 04:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656Ab3D0CwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 22:52:10 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:60559 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811Ab3D0CwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 22:52:09 -0400
Received: by mail-lb0-f182.google.com with SMTP id v20so4326673lbc.27
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 19:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=za+g9L05zO5RhJPnIP+6zkGDl2SOfXq3tXR2aW4CVBU=;
        b=FQ4iYaXkyx/Y26sOdbm0e+uSeBM6Vz6bkZJyjFTjX1D7KBcQOiBRvSxEFfwLOCl4Xg
         T2jM2IHRa0beaTeTO5liCrEMOHlfNhaa2ZT3eDHYhCKRPBMw8GZkRhBzGrKFRCsC9rxG
         fnxLhx0VaynV96GceOg0Jm7/LQvxygiI7TmwCbCJ6jxwmcc4ZLiqVMZpLBvNVJjtuRLb
         NGzIEdm5DTb8LBCL6505fymY6SG0pURdfR/WhShkM7gyBKohUGlKNOej8/N4Ivw1zOnQ
         MUf8efg8WGtdfO4VnoHPFIRGI7WxkvihXLB+6Vn1yVv0+yahF5JVRJLC3ZoRGFn/XQO3
         lj2A==
X-Received: by 10.112.139.226 with SMTP id rb2mr22293883lbb.12.1367031127185;
 Fri, 26 Apr 2013 19:52:07 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 19:52:07 -0700 (PDT)
In-Reply-To: <5176A7E4.2070608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222616>

On Tue, Apr 23, 2013 at 10:25 AM, Manlio Perillo
<manlio.perillo@gmail.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Il 21/04/2013 12:14, Felipe Contreras ha scritto:
>> On Fri, Jan 11, 2013 at 12:48 PM, Manlio Perillo
>> <manlio.perillo@gmail.com> wrote:
>>> The git-completion.bash script did not implemented full, git aware,
>>> support to complete paths, for git commands that operate on files within
>>> the current working directory or the index.
>>
>>> +__git_index_file_list_filter_compat ()
>>> +{
>>> +       local path
>>> +
>>> +       while read -r path; do
>>> +               case "$path" in
>>> +               ?*/*) echo "${path%%/*}/" ;;
>>> +               *) echo "$path" ;;
>>> +               esac
>>> +       done
>>> +}
>>> +
>>> +__git_index_file_list_filter_bash ()
>>> +{
>>> +       local path
>>> +
>>> +       while read -r path; do
>>> +               case "$path" in
>>> +               ?*/*)
>>> +                       # XXX if we append a slash to directory names when using
>>> +                       # `compopt -o filenames`, Bash will append another slash.
>>> +                       # This is pretty stupid, and this the reason why we have to
>>> +                       # define a compatible version for this function.
>>> +                       echo "${path%%/*}" ;;
>>
>> Which version of bash is that? It works perfectly fine here with or
>> without the /.
>>
>
> GNU bash, version 4.1.5(1)-release (i486-pc-linux-gnu)
> on a GNU Linux Debian 6

I compiled 4.1 and I can't reproduce, and I tried on a debian squeeze
chroot and I also can't reproduce. What am I missing?

GNU bash, version 4.1.5(1)-release (x86_64-pc-linux-gnu)

>>> +# __git_index_files accepts 1 or 2 arguments:
>>> +# 1: Options to pass to ls-files (required).
>>> +#    Supported options are --cached, --modified, --deleted, --others,
>>> +#    and --directory.
>>> +# 2: A directory path (optional).
>>> +#    If provided, only files within the specified directory are listed.
>>> +#    Sub directories are never recursed.  Path must have a trailing
>>> +#    slash.
>>> +__git_index_files ()
>>> +{
>>> +       local dir="$(__gitdir)" root="${2-.}"
>>> +
>>> +       if [ -d "$dir" ]; then
>>> +               __git_ls_files_helper "$root" "$1" | __git_index_file_list_filter |
>>> +                       sort | uniq
>>> +       fi
>>> +}
>>> +
>>> +# __git_diff_index_files accepts 1 or 2 arguments:
>>> +# 1) The id of a tree object.
>>> +# 2) A directory path (optional).
>>> +#    If provided, only files within the specified directory are listed.
>>> +#    Sub directories are never recursed.  Path must have a trailing
>>> +#    slash.
>>> +__git_diff_index_files ()
>>> +{
>>> +       local dir="$(__gitdir)" root="${2-.}"
>>> +
>>> +       if [ -d "$dir" ]; then
>>> +               __git_diff_index_helper "$root" "$1" | __git_index_file_list_filter |
>>> +                       sort | uniq
>>> +       fi
>>> +}
>>
>> These two are exactly the same, except one calls
>> __git_ls_files_helper, and the other one __git_diff_index_helper,
>> can't we make another argument that is and select one or the other
>> based on that?
>>
>
> They are not exactly the same.
>
> The first function requires, as first parameter, (space separed) options
> to pass to ls-files command; the second function, instead, requires the
> id of a tree object.
>
> IMHO, using only one function may be confusing.

The functions down in the call-stack might be doing something
different but these functions themselves are not. At the end of the
day they simply pass arguments to ls-files or diff-index.

I'm certain these can be simplified greatly.

Cheers.

-- 
Felipe Contreras
