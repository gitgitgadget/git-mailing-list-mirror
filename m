From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sun, 15 Feb 2009 13:22:29 -0800
Message-ID: <7vzlgnieei.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
 <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>
 <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de>
 <94a0d4530902141231t143067e5n872558a4e515be4a@mail.gmail.com>
 <alpine.DEB.1.00.0902142328530.10279@pacific.mpi-cbg.de>
 <7v1vtzmr9j.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902152040350.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 22:24:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYoTU-0006wV-3A
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 22:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693AbZBOVWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 16:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755571AbZBOVWi
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 16:22:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbZBOVWh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 16:22:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 529FA9AAC8;
	Sun, 15 Feb 2009 16:22:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 15A7B9AAC5; Sun,
 15 Feb 2009 16:22:30 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902152040350.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun, 15 Feb 2009 20:41:02 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C371D528-FBA6-11DD-AEB7-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110056>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 15 Feb 2009, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> >> > Or maybe even better: set a variable "ret" and at the end of 
>> >> > cmd_config(), "return !!ret;"?
>> >> 
>> >> Huh? So git commands don't return negative error values?
>> >
>> > AFAICT an exit status is supposed to be between 0 and 127.
>> 
>> Are you two talking about the return value from cmd_config()?
>> 
>> git.c::run_builtin() already knows what to do with status codes from the
>> builtins to protect you from (rare) shells that do not cope with a
>> negative return that come from the common pattern of doing:
>> 
>> 	return error("it is wrong in this way")
>> 
>> So "negative" is not really a problem.
>
> Ooops.  I missed that.

Note that I refrained from using stronger words like "regression" on
purpose, because I do not think any caller tells various error codes that
come out of git_config_set_multivar() apart and act differently in
practice.

But it does appear that the said function wants to say why the call failed
with its return code, and using !!ret to lose information does not feel
right.
