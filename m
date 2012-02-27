From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sha-1 check in rev-list --verify-objects redundant?
Date: Mon, 27 Feb 2012 10:41:41 -0800
Message-ID: <7vehtg9l0a.fsf@alter.siamese.dyndns.org>
References: <CACsJy8D_BdV14dGc2YsK91FrX8S=70DJOY3cU=oH3y41N2Ar0w@mail.gmail.com>
 <7vk43af14m.fsf@alter.siamese.dyndns.org>
 <CACsJy8BUeedTZSq_ay=JmqUt3wrnm6n1eOcFt0WPkEo2B-1zwA@mail.gmail.com>
 <20120227130141.GA8980@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 19:41:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S25W9-000080-Sb
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 19:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410Ab2B0Slp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 13:41:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59509 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899Ab2B0Slo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 13:41:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B95C5611C;
	Mon, 27 Feb 2012 13:41:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RcQvEazqx1o1zRvbM6qYhHEWtG0=; b=rTiV2l
	3ZubJnolLLsJNd72l2HG0qWViV/gN/UJ3ejmgMqNU8Q5xQ+DMHpPwduTFTbn55Qn
	u9LdcQ4SY9hiX9dKp9amqCdTQyaHBbSuzhFBu+8pEYYUWA0gONNCI4gxlZf7QvhQ
	ijLUZxoGtPI7E+zkEzX8uGT7Yo888EsNhhKtE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=elI4DaAjwn3WzU6oNlrMUNrY0el403gE
	jBNNtIMjI5l32P/7l20uofS2kzj2XINHMqev3BUDvl1uoRXz/E3buDA2d2fCWNBs
	6nSpB/sMzX/9C+JCGuYQfsHYxVosd+EWrwWtEQkeIS6mh5amMvMGldFb6ztmxfti
	BHT37RgaQkk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0F9B611B;
	Mon, 27 Feb 2012 13:41:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 435AD611A; Mon, 27 Feb 2012
 13:41:43 -0500 (EST)
In-Reply-To: <20120227130141.GA8980@do> (Nguyen Thai Ngoc Duy's message of
 "Mon, 27 Feb 2012 20:01:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1AC9000-6172-11E1-B11C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191647>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sun, Feb 26, 2012 at 06:11:30PM +0700, Nguyen Thai Ngoc Duy wrote:
>> "rev-list --objects" does check for blob existence, in finish_object().
>
> Eck.. I think "--quiet --verify-objects" becomes "--quiet --objects"
> because of this code:
>
> -- 8< --
> 	traverse_commit_list(&revs,
> 			     quiet ? finish_commit : show_commit,
> 			     quiet ? finish_object : show_object,
> 			     &info);
> -- 8< --
>
> Unless that's intentional, shouldn't we apply this patch? --quiet's
> interfering with rev-list's business sounds weird to me.

Good thinking.  Anything we are missing by calling finish_* other than
printing is a similar bug waiting to happen.

Can't we push the quiet bit in the info structure and have a single pair
of callback functions, so that we can make sure this kind of glitch would
never happen?
