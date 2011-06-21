From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/13] revert: Introduce a layer of indirection over
 pick_commits
Date: Tue, 21 Jun 2011 12:59:11 -0700
Message-ID: <7vy60v6jn4.fsf@alter.siamese.dyndns.org>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-12-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 21:59:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ76V-0000y7-MH
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 21:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791Ab1FUT7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 15:59:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab1FUT7N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 15:59:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4BF8D4C3D;
	Tue, 21 Jun 2011 16:01:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OoJBxKDt+7KiffRvWbJeP0+Qlfw=; b=Qgy2Cu
	/UOiGtUlNx+y6NUBERzliuYHlb6E45bNQRXa8BZI36XWUore8jiljeuNf/LRVFZg
	MYwtNMFQseNDG9WGuD1RyiBe2FL/02+mvHBZaFYFTs75Ujze4L0kmgo+mI2Oi99h
	u7fASARug97UhKB8kJDfzPDfBQiaLatwXOx4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m5T8aAyQ2kam6/4ILn6rSBz+JQfhLxcS
	PD3cFEVpb3/RiW/I+upL/3Mt9I9yShXmLx5OdnV+TBA93GaS1KY96z+Zlyqu77ca
	1I4WznKJHV73epVLB185GooIHYAci5r4GfxeHEJDITKu8MLgqVOQZz23C3xjjwxg
	0BT0Gm0QVl4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 43A054C3C;
	Tue, 21 Jun 2011 16:01:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 977414C3B; Tue, 21 Jun 2011
 16:01:24 -0400 (EDT)
In-Reply-To: <1308661489-20080-12-git-send-email-artagnon@gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 21 Jun 2011 13:04:47 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3DE44A6A-9C41-11E0-A7FF-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176191>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> -static int pick_commits(struct replay_opts *opts)
> +static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
>  {

Hmm, I was hoping that we would have something that can express a DAG, but
this interface seems to forever wed us with a linear history. Just making
a mental note, and not rejecting---we have to start from linear before
going fancier.
