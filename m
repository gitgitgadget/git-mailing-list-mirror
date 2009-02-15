From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sun, 15 Feb 2009 11:36:49 -0800
Message-ID: <7v1vtzlcfi.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
 <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>
 <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de>
 <94a0d4530902141231t143067e5n872558a4e515be4a@mail.gmail.com>
 <alpine.DEB.1.00.0902142328530.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 20:38:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYmos-0007DL-3m
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 20:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbZBOTg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 14:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbZBOTgz
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 14:36:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbZBOTgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 14:36:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D582B2B13E;
	Sun, 15 Feb 2009 14:36:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 17F662B335; Sun,
 15 Feb 2009 14:36:50 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902142328530.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sat, 14 Feb 2009 23:32:12 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 003D11A2-FB98-11DD-80FA-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110042>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 14 Feb 2009, Felipe Contreras wrote:
>> On Sat, Feb 14, 2009 at 9:59 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > Or maybe even better: set a variable "ret" and at the end of 
>> > cmd_config(), "return !!ret;"?
>> 
>> Huh? So git commands don't return negative error values?
>
> AFAICT an exit status is supposed to be between 0 and 127.

Are you two talking about the return value from cmd_config()?

git.c::run_builtin() already knows what to do with status codes from the
builtins to protect you from (rare) shells that do not cope with a
negative return that come from the common pattern of doing:

	return error("it is wrong in this way")

So "negative" is not really a problem.  See 2488df8 (builtin run_command:
do not exit with -1., 2007-11-13).

But if the old code was doing:

	ret = git_config_set_multivar(...);
        if (ret)
		return ret;

and if you are changing it to:

	ret = git_config_set_multivar(...);
        if (ret)
		return !!ret;

you are changing an externally observable behaviour.
