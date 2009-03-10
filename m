From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 12:11:24 +0100
Message-ID: <49B64ADC.2090406@viscovery.net>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net> <alpine.DEB.1.00.0903101153250.14295@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 10 12:13:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgzte-0007YJ-Ch
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 12:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbZCJLLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 07:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbZCJLLm
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 07:11:42 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53736 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbZCJLLl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 07:11:41 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lgzrp-0002LF-3f; Tue, 10 Mar 2009 12:11:25 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2F8B14FB; Tue, 10 Mar 2009 12:11:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <alpine.DEB.1.00.0903101153250.14295@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112804>

Johannes Schindelin schrieb:
> On Tue, 10 Mar 2009, Johannes Sixt wrote:
>> This removes the last parameter of recv_sideband, by which the callers
>> told which channel band #2 data should be written to. Since both callers
>> of the function passed 2 for the parameter, we hereby remove the
>> parameter and send band #2 to stderr explicitly using fprintf.
> 
> To be honest, I considered this myself.
> 
> But I think it is wrong.  Just because the current callers happen to 
> output to stderr does not mean that we would not like sidebands that 
> exchange binary data for other uses in the future.
> 
> I am thinking GitTorrent here.

Clearly, we are looking at git here, not GitTorrent. "Because we could" is
IMNSHO not a good justification keep code unnecessarily complicated.

> And clearly, sideband support was written with future uses like that in 
> mind, as it goes out of its way to transmit packets instead of strings.

All data producers and data consumers *in git* use band #2 to transport
error messages and progress report. GitTorrent cannot not talk to
upload-pack or upload-archive and expect to get arbitrary binary data over
band #2.

For use-cases that you have in mind in GitTorrent, the *protocol* may be a
good choice, but the current implementation is definitely a special case.

-- Hannes
