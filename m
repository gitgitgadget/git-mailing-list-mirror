From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv1] Export file in git-remote-mediawiki
Date: Sun, 10 Jun 2012 15:01:27 +0200
Message-ID: <vpqehpnnwwo.fsf@bauges.imag.fr>
References: <1339162024-3120-1-git-send-email-nguyenkimthuat@gmail.com>
	<vpqwr3hrj6s.fsf@bauges.imag.fr>
	<c23d4a113c735e093e3e9b06e4f16a70@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: nguyenki <nguyenki@ensibm.imag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 10 15:01:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdhm1-0000bv-Ob
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 15:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab2FJNBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 09:01:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36069 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780Ab2FJNBg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 09:01:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5ACqRlJ032016
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 10 Jun 2012 14:52:27 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sdhlo-0004Ds-KG; Sun, 10 Jun 2012 15:01:28 +0200
In-Reply-To: <c23d4a113c735e093e3e9b06e4f16a70@ensibm.imag.fr>
	(nguyenki@ensibm.imag.fr's message of "Sat, 09 Jun 2012 00:59:22
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 10 Jun 2012 14:52:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5ACqRlJ032016
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339937552.48804@kdDdVhqz8f2a2swIi+rOig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199599>

nguyenki <nguyenki@ensibm.imag.fr> writes:

>>> +	my %hashFiles = get_file_extensions_maybe($complete_file_name);
>>
>> What does this function do? My first understanding was that it
>> queried
>> the wiki for allowed file extensions, but why does it need the file
>> name? It does nothing if $complete_file_name ends with .mw, but then
>> why
>> do you run it before entering the following if() statement?
>>
>>>  	if (substr($complete_file_name,-3) eq ".mw") {
>>>  		my $title = substr($complete_file_name,0,-3);
>>
>  This function will get a list of allowed file extensions. It need the
> file name to verify if this name begins with .mw or not. If not, it
> does nothing like
> you said. But if $complete_file_name is not a wiki page (end with
> .mw), the function will return the list of file extensions %hashFiles
> to verify if this file is allowed in this condition:

If $complete_file_name is not a wiki page, you basically don't need to
call this function. As I said, move the call to the function within the
next "if" statement, and you won't need this extra complexity.

> Yes, i'll correct it in the next patch.
> For the moment, i added these lines to deal with the case similar -
> the case when an user tries to upload a file or pages but he doesn't
> have sufficient rights or he failed to login.
>
> +sub error_insufficient_right {
> +       print STDERR "Can not delete or upload file and wiki pages\n";
> +       print STDERR "You don't have right to do it\n";
> +       print STDOUT "error $_[0]\"right insufficient\"\n";
> +       return 0;
> +}

This is still a regression. The previous version was propagating page
deletion as "replace content with [[Category:Deleted]]", which did work
with insufficient priviledge.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
