From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -p: skip conflicted paths
Date: Wed, 28 Mar 2012 14:58:30 -0700
Message-ID: <7vaa30tmk9.fsf@alter.siamese.dyndns.org>
References: <7viphov839.fsf@alter.siamese.dyndns.org>
 <1332966017-6100-1-git-send-email-kusmabite@gmail.com>
 <7viphotng8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	hellmuth@ira.uka.de
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:58:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD0t5-00070I-RN
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 23:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758640Ab2C1V6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 17:58:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37001 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758300Ab2C1V6e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 17:58:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D14537638;
	Wed, 28 Mar 2012 17:58:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V0HVU5/Yw/hiIznrWA42/f7ycNI=; b=Y1cdyH
	HbMtqn2FQiWcv3D/5XgzOwkluxQ9kUXhDRRj9Uwnj4omNTLjvAyL3J/4+Lm9IUF3
	SqnTb5g7+BxNpHK+YHzopr3NFsYKVvy4007JlBCRyu1rQmArWYNp1drAsaRPwozC
	2TR+OGOyIw5AeGbiie/U+20SkusKIZq+iL9Bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qFLyPgP3fvlZsCzv4VBw30ZSf1ZaoaYa
	/Hj9LKEjhnicUKqauiwHDlSAgsedRmrjRqMP8olM5gmYLiOygNHOQRZHxIaDriky
	fsfN7kOFF3/USrWCbexgSdaUiHcuScHA/IskJIr+1eCpyad1FvHA2/SCp74PLRQh
	OYSv4CqxIqM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C77747637;
	Wed, 28 Mar 2012 17:58:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46D0F7636; Wed, 28 Mar 2012
 17:58:33 -0400 (EDT)
In-Reply-To: <7viphotng8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 28 Mar 2012 14:39:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29624462-7921-11E1-8CA9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194207>

Junio C Hamano <gitster@pobox.com> writes:

> I was hoping that we could somehow do this with a single invocation of
> ls-files, instead of doing it over and over inside a loop.
>
> Totally untested, but something along this line...

Well, probably along that line but not there.  I think the patch would be
a lot cleaner to keep the part I touched intact, and instead add an extra
"ls-files -u" that creates %unmerged hash in the way this patch does,
immediately before the last for() loop in the function.  And then the loop
can use %unmerged hash to filter the elements.
