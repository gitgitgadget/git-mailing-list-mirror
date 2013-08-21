From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] git-remote-mediawiki: reset private ref after non-dumb push
Date: Wed, 21 Aug 2013 22:26:17 +0200
Message-ID: <vpqy57u7pue.fsf@anie.imag.fr>
References: <1377072617-25086-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq1u5nudq8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 22:26:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCEzI-0006nb-Cz
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 22:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab3HUU0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 16:26:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48175 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393Ab3HUU0d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 16:26:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7LKQFMg007398
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 21 Aug 2013 22:26:17 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VCEyv-0001lX-N5; Wed, 21 Aug 2013 22:26:17 +0200
In-Reply-To: <xmqq1u5nudq8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 21 Aug 2013 10:59:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 21 Aug 2013 22:26:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7LKQFMg007398
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377721577.70096@CNBtMBCHCYua3GizEpNOTw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232726>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
>> index f8d7d2c..13919ad 100755
>> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
>> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
>> @@ -53,6 +53,7 @@ if (@ARGV != 2) {
>>  
>>  my $remotename = $ARGV[0];
>>  my $url = $ARGV[1];
>> +my $reset_private_ref_to = undef;
>>  
>>  # Accept both space-separated and multiple keys in config file.
>>  # Spaces should be written as _ anyway because we'll use chomp.
>> @@ -161,6 +162,9 @@ sub parse_command {
>>  	my ($line) = @_;
>>  	my @cmd = split(/ /, $line);
>>  	if (!defined $cmd[0]) {
>> +		if ($reset_private_ref_to) {
>> +			run_git("update-ref -m \"Git-MediaWiki non-dumb push\" refs/mediawiki/$remotename/master $reset_private_ref_to");
>> +		}
>
> So reset-private-ref-to is recorded for a non-dumb push, but...

> ... it is set for dumb-push?  I am confused.

Oops, I'm the one who did the confusion indeed. It should be
s/non-dumb/dumb/ here and in the subject line.

Don't merge this one, I've fixed locally and will resend (this or
another fix, depending on the outcome of the discussion).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
