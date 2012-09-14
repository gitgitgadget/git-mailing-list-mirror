From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: fix refspec on "--single-branch" option
Date: Fri, 14 Sep 2012 09:02:48 -0700
Message-ID: <7v7grw7ftj.fsf@alter.siamese.dyndns.org>
References: <CAN0XMOKszADpeaCG7VhL-AZ3m7_hSWV3NhEmPuH6FETzs=eDNg@mail.gmail.com>
 <1347599357-15533-1-git-send-email-ralf.thielow@gmail.com>
 <7vr4q56uae.fsf@alter.siamese.dyndns.org>
 <7vipbh6qxa.fsf@alter.siamese.dyndns.org>
 <CACsJy8BLwd=XeHFqg5jb=yx3p6xdKuzvG+KvfotfLf0vfSZdRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 18:03:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCYM8-0001Cz-Ns
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 18:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759056Ab2INQCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 12:02:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55293 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755996Ab2INQCv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 12:02:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99FB771AA;
	Fri, 14 Sep 2012 12:02:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S2Pwqh+f5MGh1t/39Ug8hCp1AVg=; b=ldu1L9
	i768kjbna4AH+YmLl/mUcg0NzT9IgVNbqtAiGbIIWE85VgvVOOn1Ygtmi+Ta6phu
	e+CVLNYYh8xGXFRamJwVeDWdy6RXkfzEYr3XozBSlxy7fJxCZiqHoKr2PoWRRrUl
	jMTNJi9VnFO/EIafpysnQbVGvFYnCfvQjy2Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=brRMdbxAhp/+nRDbvHhRintzMdE5YCah
	hFXJ+F7Bssg9WS3vQPMG729WDAkvi/rzxkIsLr78jj1iw4dvsrK1NHmymYwmMXvx
	mA8GHYzWGywjv3eDFsPzvn1mWG6fvRK2U9j6g8waNLwg81HyN+AbIwfG4NIITUod
	gzTbePfq5pw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85E2F71A9;
	Fri, 14 Sep 2012 12:02:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E09B371A8; Fri, 14 Sep 2012
 12:02:49 -0400 (EDT)
In-Reply-To: <CACsJy8BLwd=XeHFqg5jb=yx3p6xdKuzvG+KvfotfLf0vfSZdRQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 14 Sep 2012 20:10:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1F77958-FE85-11E1-A687-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205497>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Fri, Sep 14, 2012 at 1:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Alternatively, if you can move the logic to set up this
>> configuration further down so that it happens after we talked to the
>> other side and figured out remote_head_points_at, you could instead
>> set it up to keep a single remote tracking branch.
>
> That sounds reasonable. I have a question though, what should a user
> do when he/she want to fetch all branches again? Messing up with
> refspec in config file is not something I would like to do.

You first have to think ;-).

I would say there are two kinds of users.

 - To the simplistic ones who fear the power of configuration, we
   can simply tell "You don't. Use 'single' when you want to keep
   working with the single branch. If you want full, reclone, and
   migrate your work from the single one by fetching from it to the
   full clone before discarding the single one".

 - To the ones who wants to take the full advantage of flexibility
   of configuration, we can tell "remotes.$name.fetch configuration
   is your friend. Do whatever you want to do with it, but here are
   two hints".  The hints would cover the case to revert to the
   default refspec, and the case to add another specific branch.

These days, with "git config" and "git remote" wrappers, I do not
particularly see a need to fear the power of configuration, though.
