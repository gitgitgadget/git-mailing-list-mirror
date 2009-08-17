From: Karthik R <karthikr@fastmail.fm>
Subject: Re: [PATCH] GIT_SSH does not override ssh in git-svn
Date: Mon, 17 Aug 2009 17:35:34 -0500
Message-ID: <4A89DB36.6060508@fastmail.fm>
References: <4A89C6F8.3010100@fastmail.fm> <7vhbw6qfuq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 00:36:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdAoU-0006yI-1l
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 00:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758239AbZHQWfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 18:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758220AbZHQWfq
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 18:35:46 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46363 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758218AbZHQWfq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 18:35:46 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CF2B051BF5;
	Mon, 17 Aug 2009 18:35:46 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 17 Aug 2009 18:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=uq9J5iri2OdangUGS19r80OnvGM=; b=OC9qimeedXkyJsVMkIeSKbX2guqP+qigQAuNsI2AsNPns5XBd1mKWSDoNKfC4DsjnHkNYdJS9PCcRehMohfq79d7snj2zzEXHvLe5vyzgLwjOVSSZLKuQTlopYXdLbYDJJmOM4dVNhd/DykWSnKCCrFVzx0XFIKpUmAeSAlTc9c=
X-Sasl-enc: G9IqBIhiK1D8FTcXz8hAVUdMc+fDkUSGbMCRSUG87ucY 1250548546
Received: from [0.0.0.0] (99-156-81-160.lightspeed.austtx.sbcglobal.net [99.156.81.160])
	by www.fastmail.fm (Postfix) with ESMTPSA id 03D7194D3;
	Mon, 17 Aug 2009 18:35:45 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090605)
In-Reply-To: <7vhbw6qfuq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126308>

Junio C Hamano wrote:
> Karthik R <karthikr@fastmail.fm> writes:
>
>   
>> +my $git_ssh_user_set = 1 if defined $ENV{GIT_SSH};
>> +if ($git_ssh_user_set) {
>> +       # If GIT_SSH is set, also set SVN_SSH...
>> +       $ENV{SVN_SSH} = $ENV{GIT_SSH};
>> +       # ... and escape \s in shell-variable on Windows
>> +       if ($^O eq 'MSWin32' || $^O eq 'msys') {
>> +               $ENV{SVN_SSH} =~ s/\\/\\\\/g;
>> +       }
>> +}
>> +
>>     
>
> Why not just
>
> 	if (defined $ENV{GIT_SSH}) {
>         	...
>
> ???
>
>   
>> $Git::SVN::Log::TZ = $ENV{TZ};
>> $ENV{TZ} = 'UTC';
>> $| = 1; # unbuffer STDOUT
>> -- 
>> 1.5.4.3
>>     
I think I had trouble getting that to work correctly on my Windows XP
box... I didn't dig into that (my perl was exactly 1 day old).

Does this look better (it does to me) ? If so, I can resend the patch
addressing Dscho's comments too.

+# If GIT_SSH is set, also set SVN_SSH...
+$ENV{SVN_SSH} = $ENV{GIT_SSH} if defined $ENV{GIT_SSH};
+# ... and escape \s in shell-variable on Windows
+if ($^O eq 'MSWin32' || $^O eq 'msys') {
+       $ENV{SVN_SSH} =~ s/\\/\\\\/g if defined $ENV{SVN_SSH};
+}
+
