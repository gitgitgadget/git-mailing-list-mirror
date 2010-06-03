From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: About [PATCH 2/2] gitweb: Create a perl module to handle gitweb 
	cgi params and vars
Date: Thu, 3 Jun 2010 15:22:32 +0530
Message-ID: <AANLkTilYSAj_byhZ1WDEBrYOAj6OZVsyDmp59vuK0tQz@mail.gmail.com>
References: <201006022229.31593.jnareb@gmail.com>
	<201006031055.28966.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 11:59:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK7Cw-0006iQ-5l
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 11:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758898Ab0FCJ7T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 05:59:19 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:60773 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758821Ab0FCJ7R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 05:59:17 -0400
Received: by ywh9 with SMTP id 9so6155410ywh.17
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7TcdnDxcEbCeRIHZOXtFwuVNNs+aea5zTifSMN+OJWM=;
        b=Cz9XoU6B6l2JNY3lXZ1yk8hTd8XNmyEh7CpXmuaQfz5A6gNDFrVQz6O9AaF2GUtNc7
         gtM7DOsqpGTKdJ+wzFe1Elpy5uC6qrbOZ9ynQtJE3en1ESXtShUmENsVfzlpftFGiYRE
         WkM62epViJXPUe30eYkLhEGMQlpILoRQ8ZIJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aacn16YuFsIjX1WQwx4nqXBUnRJBgLwYKGEdzgQHno4wQbRQj03VeQpixUIa2mwiC5
         hGk1VdoLSye/W9ODbp6KcRnhFbvPCsQguS3xS/8ScpPHMsaZvH+vXsRDpz2L5EPGVcbY
         oXlzFM37DKu+odAtE0E6pRbBeadoEyYlwtJFc=
Received: by 10.100.246.13 with SMTP id t13mr10454834anh.183.1275558752511; 
	Thu, 03 Jun 2010 02:52:32 -0700 (PDT)
Received: by 10.100.126.20 with HTTP; Thu, 3 Jun 2010 02:52:32 -0700 (PDT)
In-Reply-To: <201006031055.28966.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148302>

> Shouldn't evaluate_query_params(), evaluate_path_info(), and the
> subroutine that ties them together evaluate_and_validate_params() be
> in Gitweb::Request too?
>
>>
>> =A0sub evaluate_git_dir {
> [....]
>> =A0}
>
> Ditto with evaluate_git_dir()?

Well, evaluate_and_validate_params() and evaluate_path_info() contains
calls to subroutines which are not yet moved into any package. So,
what do you want to in such a case ?

> BTW. as I said in comment to previous patch, vriables such as $projec=
t
> should be put in Gitweb::Request in my opinion, not in Gitweb::Config=
=2E
> Perhaps they are, but it is not obvious from this patch.
>
>>
>> =A0our (@snapshot_fmts, $git_avatar);
>> @@ -643,32 +605,32 @@ set_message(\&handle_errors_html);
>>
>> =A0# dispatch
>> =A0sub dispatch {
> [...]
>> =A0}
>>
>> =A0sub run_request {
>
> Those two subroutines should not, I guess, be put in Gitweb::Request.
> They would be in catch-all Gitweb module, I guess, or perhaps in the
> later post-GSoC future in Gitweb::Dispatch or something.

Yes.

>> @@ -689,7 +651,6 @@ sub run_request {
>> =A0our $is_last_request =3D sub { 1 };
>> =A0our ($pre_dispatch_hook, $post_dispatch_hook, $pre_listen_hook);
>> =A0our $CGI =3D 'CGI';
>> -our $cgi;
>> =A0sub evaluate_argv {
>> =A0 =A0 =A0 return unless (@ARGV);
>
> Ah, so $CGI is left in gitweb.perl, $cgi is moved to Gitweb::Request.
>
> [cut more than half of patch, which sould not be needed with exportin=
g
> =A0variables and not using fully qualified variable names]
>
>> diff --git a/gitweb/lib/Gitweb/Request.pm b/gitweb/lib/Gitweb/Reques=
t.pm
>> new file mode 100644
>> index 0000000..91cc492
>> --- /dev/null
>> +++ b/gitweb/lib/Gitweb/Request.pm
>> @@ -0,0 +1,58 @@
>> +#!/usr/bin/perl
>> +#
>> +# Gitweb::Request -- gitweb request(cgi) package
>> +#
>> +# This program is licensed under the GPLv2
>
> I don't remember what is git policy on copyright statements, and on
> GPLv2 vs GPLv2+...
>
>> +
>> +package Gitweb::Request;
>> +
>> +use strict;
>> +
>> +BEGIN {
>> + =A0 =A0 use Exporter();
>> +
>> + =A0 =A0 @Gitweb::Request::ISA =3D qw(Exporter);
>> + =A0 =A0 @Gitweb::Request::EXPORT =3D qw();
>> +}
>
> Same comment as for previous patch.
>
> =A0 use Exporter qw(import);
> =A0 our @EXPORT =3D qw($cgi, $my_url, $my_uri, $base_url, ...);
>
> BTW with exporting variables you can easily see here that
> Gitweb::Request does not use any variable from Gitweb::Config.
>
>> +
>> +our ($cgi, $my_url, $my_uri, $base_url, $path_info, $home_link);
>> +our ($action, $project, $file_name, $file_parent, $hash, $hash_pare=
nt, $hash_base,
>> + =A0 =A0 $hash_parent_base, @extra_options, $page, $git_dir);
>> +our ($searchtype, $search_use_regexp, $searchtext, $search_regexp);
>> +
>> +sub evaluate_uri {
> [...]
>> +}
>
> Straightforward code movement. =A0But see comment above on which
> subroutines I feel should be also put in Gitweb::Request.

Please answer the question regarding calls to not-yet-packaged subrouti=
nes.

Thanks,
Pavan.
