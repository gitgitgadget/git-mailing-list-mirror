From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/19] tree-diff.c: reserve space in "base" for pathname
 concatenation
Date: Mon, 13 Dec 2010 21:32:25 -0800
Message-ID: <7vvd2wvs0m.fsf@alter.siamese.dyndns.org>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-10-git-send-email-pclouds@gmail.com>
 <7vlj3t35ol.fsf@alter.siamese.dyndns.org>
 <AANLkTi=5QgkBd434=Z7MCA_ZNZCXVyXJYh_fd1A+B2ue@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 06:32:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSNVC-0004eb-O6
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 06:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801Ab0LNFcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 00:32:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab0LNFcg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 00:32:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8DDD344CF;
	Tue, 14 Dec 2010 00:32:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WGDeDLHOLdrrVuL4MmGbfvDpHso=; b=QOwqOV
	EhCKAEAocD+msXjnHi1zqezF6tdYkWZk2pKibRbhTjlfv8SGhtuAUD3TFvAGCMIh
	G/p93WQo3lFj1NTEVgtX6Tbj7IJO6EvBAvVRKYJe0lDV3b8C17aRKJA4jAl5BdJr
	WhYtLSV3zt/20ccdPTkG3CMwqtp2WoXrGXriU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h10nWq3aVx4JBJPUm2NuAMdE5lYFLVVT
	aEgeQ4TpPOUewtVN3Xw4BKv2iOv+Hc3PjRUz1efjTuXdU2+HhcpyRFJSKtwhrh2a
	KNj/r+Oug1BIm/c5zwLPoKCgNPcsHESggCK8K1GNBS+tCliwQqlMYOhtZ6VtL72+
	owcrN4Wt1+0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 601F844CE;
	Tue, 14 Dec 2010 00:32:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7016D44CD; Tue, 14 Dec 2010
 00:32:54 -0500 (EST)
In-Reply-To: <AANLkTi=5QgkBd434=Z7MCA_ZNZCXVyXJYh_fd1A+B2ue@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Tue\, 14 Dec 2010 12\:00\:11 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9B73F8B2-0743-11E0-BF53-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163627>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> All paths should not exceed PATH_MAX, right?

Your PATH_MAX may be a lot shorter than the PATH_MAX on the system I
created my trees on that you are reading.  Besides, you can create
arbitrarily deep tree structure without busting the limit on the
filesystem by writing tree objects by hand.

In other words, all paths shouldn't exceed PATH_MAX, but the responsiblity
to verify that is _yours_.
