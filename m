From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] make verify_one_pack() a bit less wrong wrt
 packed_git structure
Date: Sat, 01 Mar 2008 12:25:34 -0800
Message-ID: <7vwsomxkch.fsf@gitster.siamese.dyndns.org>
References: <1204176320-31358-1-git-send-email-nico@cam.org>
 <1204176320-31358-2-git-send-email-nico@cam.org>
 <1204176320-31358-3-git-send-email-nico@cam.org>
 <7vk5kn7znz.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803010305230.2899@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 21:26:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVYHz-0002Z9-6r
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 21:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758208AbYCAUZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 15:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758195AbYCAUZx
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 15:25:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758189AbYCAUZv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 15:25:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5F52F161B;
	Sat,  1 Mar 2008 15:25:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C1CA9161A; Sat,  1 Mar 2008 15:25:45 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75697>

Nicolas Pitre <nico@cam.org> writes:

>> I just quickly looked at verify_packfile() after applying your
>> series, and it seems that nothing tries to access objects with
>> only their SHA-1 names without explicitly telling which pack to
>> read from, so it should still be safe even if we did not install
>> the packed git (iow, the normal codepath would not try to pick
>> up objects from the suspect pack that is being validated).
>> 
>> But it made me feel a bit worried.
>
> The problem is with the patch that follows, which calls init_revindex(). 

Oh, Ok.

I see nobody other than pack-check calls packed_object_info_detail, and
that would be the only codepath that would load revindex in-core, so the
change would be fine.  I was worried about having to load revindex which
would not help anything but info-detail which is pretty much useless for
most operations.
