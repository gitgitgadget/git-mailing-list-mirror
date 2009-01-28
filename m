From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3] gitweb: make static files accessible with PATH_INFO
Date: Wed, 28 Jan 2009 01:43:20 +0100
Message-ID: <cb7bb73a0901271643g7c3a8c42qff6025187ab3c081@mail.gmail.com>
References: <1233062946-22395-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200901280114.59388.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 01:44:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRyXw-00008s-GO
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 01:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbZA1AnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 19:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbZA1AnX
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 19:43:23 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:45658 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbZA1AnX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 19:43:23 -0500
Received: by ewy14 with SMTP id 14so2502004ewy.13
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 16:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Xws+mckaq9gQ9abrlkbGDukEtJyhx51f5xEsuWT9d+E=;
        b=D0s882n5LKhBRlWPtCH6p/uqa2cTGaqYUmjvVwtjVoQKulx3o04gop/Wr9VEd9C5xd
         VquyvAnUcMUmKgGWdukGU+UQbW2WSaLb5SRKDgRcsrgUMt0Ua7Z3liaIgA6KhGqbEo2j
         J7hLYAD+gjaevmqRFLdKV/bhknQ5d8wbjnK4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ig5pIx4HHDIWe1qAi3wL8W/iu50ncnn9xuba/L3Rg6mK8ZVvnkY4EY8rukm8lNgHZi
         lETA5oHZiuHNd3MfU0TbUK7WegAMMx9Dvs3RIkuqweZvOiqst+r8vLVliz3EoKulZotx
         NyvmUJUuA//cnbPxu9uc0jOOVCNLlvwSG3qyE=
Received: by 10.210.141.17 with SMTP id o17mr2781496ebd.182.1233103400726; 
	Tue, 27 Jan 2009 16:43:20 -0800 (PST)
In-Reply-To: <200901280114.59388.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107435>

On Wed, Jan 28, 2009 at 1:14 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Tue, 27 Jan 2009, Giuseppe Bilotta wrote:
>
>> When PATH_INFO is defined, static files such as the defalt CSS or the
>                                                      default
>
>> shortcut icon are not accessible beyond the summary page (e.g. in
>> shortlog or commit view).
>>
>> Fix this by adding a <base> tag pointing to the script base URL.
>
> By the way, I have thought that it would conflict with use path_info
> for 'blob_plain' action to have links work in document... but I forgot
> that then we do not use gitweb HTML header...
>
>>
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>> Of course, last time I forgot that the BASE href is supposed to be
>> absolute. While Opera apparently has no problem with it being relative,
>> other browsers such as Firefox are stricter about it.
>
> Errrr... I think you are talking about _full_ vs. _absolute_, not
> _absolute_ vs. _relative_, see below.

No, I actually mean absolute vs relative in the URI sense, not in the
Perl/CGI sense.

http://www.example.com/ is absolute, / is relative

>>  gitweb/gitweb.perl |    8 ++++++++
>>  1 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 931db4f..411b1f6 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -2901,6 +2901,14 @@ sub git_header_html {
>>  <meta name="robots" content="index, nofollow"/>
>>  <title>$title</title>
>>  EOF
>> +# the stylesheet, favicon etc urls won't work correctly with path_info unless we set the appropriate base URL
>
> Errr... could you please break this line to not have it overly long?

Ah yes, sorry.

>> +     if ($ENV{'PATH_INFO'}) {
>> +             my $base = $my_url;
>
> Hmmm...
>
>  our $my_url = $cgi->url(); # = $cgi->url(-full);
>  our $my_uri = $cgi->url(-absolute => 1);
>> +             my $sname = $ENV{'SCRIPT_NAME'};
>> +             $base =~ s,\Q$sname\E$,,;
>> +             $base .= "/";
>
> I don't think that is required; neither of $my_url and $my_uri ends
> with '/' after stripping path info:
>
>  our $path_info = $ENV{"PATH_INFO"};
>  if ($path_info) {
>        $my_url =~ s,\Q$path_info\E$,,;
>        $my_uri =~ s,\Q$path_info\E$,,;
>  }
>
> and if BASE is a document, then relative URLs are resolved using
> dirname of BASE, I guess, as
>  http://www.w3.org/TR/html401/struct/links.html#edef-BASE
> contains in example:
>  <BASE href="http://www.aviary.com/products/intro.html">
>
> See also RFC1808 (Relative Uniform Resource Locators), section
> 4.  Resolving Relative URLs:
>
>   Step 6: The last segment of the base URL's path (anything
>           following the rightmost slash "/", or the entire path if no
>           slash is present) is removed and the embedded URL's path is
>           appended in its place.[...]

Ah, good point, I had missed this part, so we can actually keep the
script name in the url. Good.

> Besides, if you strip SCRIPT_NAME, then you are left with document
> root; this means that if git-logo.png etc. are in the same directory
> as gitweb.cgi, they won't be found.  For example for me it doesn't
> work correctly (I have git-logo.png along gitweb.cgi, which is in
> /cgi-bin/gitweb/... and thanks to symlinks also in /gitweb/).

They won't be found only if you have gitweb.cgi as directory index. In
that case you obviously need a rewrite rule at the server level
anyway. The one I use is

RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^.* gitweb.cgi/$0 [L,PT]

tha means 'server static files and turn anything else into pathinfo
for gitweb.cgi'

We probably want to document that. Notice that it's an issue
regardless of this particular patch.

> By the way, according to documentation $cgi->url() should *not*
> contain path_info; you have to use $cgi->url(-path_info=>1) for
> that... strange.

I think there's a bug in CGI.pm when the script is the directory index.

>> +             print "<base href=\"$base\"/>\n";
>
> Just in case, to be compatible with both XHML and HTML, we should use
>
> +               print "<base href=\"$base\" />\n";

> ...if not for the fact that surrounding code doesn't use this way...

That's the reason why I kept it that way, yes.

-- 
Giuseppe "Oblomov" Bilotta
