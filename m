From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/19] completion: make __gitdir() store repository path
 in $__git_dir
Date: Wed, 09 May 2012 12:36:19 -0700
Message-ID: <7vehqtrvt8.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-8-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 21:36:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSCgW-0003mS-5q
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 21:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760868Ab2EITgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 15:36:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55638 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437Ab2EITgV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 15:36:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13BC688A9;
	Wed,  9 May 2012 15:36:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ssjDUMdQzkkW
	D7tkd8r06JCq2YI=; b=jHtw5hVrBNGkz28W4BoEhLmHVz1zOok5rLcrp60xcUET
	ycKGI9d+c7KyerBXRkk5kXV/MpS63G9snuFMN5lv3sAnUbpcth70d0ZVlBZS8A/T
	wwy8CoV0xwlATwLhp5nxNUcvFYOeLRZpzvfc7aZuBVP1PxxB0T4tWetxym43ePA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u9oh0E
	55Hzt4grJr7SQUFaz72AeCfHODmGLvQlsLHJ1d7mU5ffoeOdbxDRr3fH1z1YxPki
	DJqjY3BHWAnaQiChJ5gso1FCnMaTNNeBSZ1FW+ysWdj1TvpA0ODxWcy/+4aynWaM
	lv27JfwEJSIzMxs9FcZdugNXwSfnnMWtXfaBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B7C988A8;
	Wed,  9 May 2012 15:36:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E70088A7; Wed,  9 May 2012
 15:36:20 -0400 (EDT)
In-Reply-To: <1336524290-30023-8-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 9 May 2012 02:44:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40D7C488-9A0E-11E1-95DF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197495>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> Also declare $__git_dir as local in __git_ps1() and _gitk() to preven=
t
> the variable from leaking into the environment when they call
> __gitdir() (that would break completion and bash prompt when the user
> moves to a different git repository).

Good; this was actually the only major thing I worried about when I saw
the tail part of the series.  So $__git_dir is global across the call
chain of a single invocation to show __git_ps1, but it always is reset
once __git_ps1 is called again, so that it will always know where the
then-current git repository is, right?

Looks quite a sane and valid optimization to me.
