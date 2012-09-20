From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] pretty: support right alignment
Date: Thu, 20 Sep 2012 09:40:49 -0700
Message-ID: <7v392cd4vi.fsf@alter.siamese.dyndns.org>
References: <CACsJy8BP0vzWG-Po=WBVC_V5Z5_ysoCOTkU-XV3Hy_jVE4H1XQ@mail.gmail.com>
 <1348143976-4506-1-git-send-email-pclouds@gmail.com>
 <1348143976-4506-3-git-send-email-pclouds@gmail.com>
 <20120920143803.GA9527@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 18:41:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEjoH-00037H-A5
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 18:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160Ab2ITQkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 12:40:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38813 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab2ITQkw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 12:40:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0E1895F8;
	Thu, 20 Sep 2012 12:40:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kz1JYJvlx8hKoneSQkEihqdHBqE=; b=XxZEzl
	OLi+Jkz1oH22xgHUCm9tfCdSEoTIa0br70hvoMQAVqBq7unloCngJgNpDYzRBTiT
	Dzr1nf67ERF56v5JoJ/JGzALKiwn/htRl7rO5Q03KmHIStkZiZQovSdkFg6ylVfo
	O5XvIf6oduKTF6CAvFsn2pr2Bwl2Kb6rzmtX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BKRZlbr+1A6LwGbd+8EOmKbQE/QBahJA
	B+sPNUslMdLGahKmlTUY48DlxSB+Ctxd0eIGWodkemG1Jwpdz+ExTnc9hcWWA7En
	Np3VK1CKkH58Pd045FV7VNkiPh3fhFPi9XE970blOO7GYNm9ap5zwAOBxpv1B8jm
	5rSPhN7Va/s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F07695F7;
	Thu, 20 Sep 2012 12:40:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 077F095F6; Thu, 20 Sep 2012
 12:40:50 -0400 (EDT)
In-Reply-To: <20120920143803.GA9527@lanh> (Nguyen Thai Ngoc Duy's message of
 "Thu, 20 Sep 2012 21:38:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F017ED96-0341-11E2-BB5F-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206052>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> And this is a for-fun patch that adds %| to right align everything
> after that. I'm ignoring problems with line wrapping, i18n and so
> on. "%C+%h %s%|%d" looks quite nice. I'm not sure how much useful it
> is beyond --oneline though. It looks something like this
> ...
> [oneline output ellided]
> ...

I think this is a great feature at the conceptual level, and you
know "but" is coming ;-).

 - Shouldn't it be "everything from there until the end of the
   current line" than "everything after that"?

 - How is the display width determined and is it fixed once it gets
   computed?

 - How does this interact with the wrapped output?  Should it?

 - I am wondering if somebody ever want to do this with a follow-up
   patch:

	Left %h%|Center %cd%|Right %ad

   Is %| a sensible choice for "flush right"?  I am wondering if it
   makes more sense to make %|, %< and %> as "multi-column
   introducer" (the example defines output with three columns) that
   also tells how text inside each column is flushed inside the
   column, e.g.

	%>col 1 right flushed%|col 2 centered%< col 3 left flushed

   or something like that (we may want explicit "column width"
   specifiers if we were to do this kind of thing).
