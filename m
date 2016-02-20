From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Sat, 20 Feb 2016 13:32:17 -0800
Message-ID: <xmqqr3g79ify.fsf@gitster.mtv.corp.google.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
	<1455772670-21142-26-git-send-email-dturner@twopensource.com>
	<20160218085023.GA30049@lanh>
	<1455827001.7528.87.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 22:32:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXF8f-0004T8-P7
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 22:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759442AbcBTVc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 16:32:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752563AbcBTVcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 16:32:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5E544319D;
	Sat, 20 Feb 2016 16:32:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yhyc4B/f5odXtfDYFi7z1vNlG4Q=; b=xsW9+b
	126rL2axFo00rUj4r02KNkwU4sBy/0S2aT6Oc9UojsVkgXao4JswwIiWI2Haipck
	fS49OuGkWa0TfQZ61Owcxnu6WJySm3yBTjxydi6HDW94k5vD0bnVIRPGV64rlPTe
	N0KB2rWfQpWFdMy6Lt8ZhLS19PcadaYNQ0Nl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dvh68GK87eBMIRCEikle+PpPCY3PkSIr
	z9I1BXiSh5Zwk5y+E2PLzEOOJNasNP3Cf1KdYCz94dmLAtagvTC7LsvwQjip7J0w
	j1GDeiAF/KYXwa3WtkD1Fon+zV1KLQ5tk/II4GXxMEepN1KYn1h+sQ/tKurE5B8t
	ZxFoCGo9ELg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E20C4319C;
	Sat, 20 Feb 2016 16:32:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0A2664319B;
	Sat, 20 Feb 2016 16:32:18 -0500 (EST)
In-Reply-To: <1455827001.7528.87.camel@twopensource.com> (David Turner's
	message of "Thu, 18 Feb 2016 15:23:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B4B3DCE-D819-11E5-9F03-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286788>

David Turner <dturner@twopensource.com> writes:

> So just add this after every mkdir?
>
> 	if (shared_repository)
> 		adjust_shared_perm(db_path);

The function itself checks shared_repository configuration, so the
caller does not have to bother.  You should rather treat it as a
declaration and a documentation that says "this path in $GIT_DIR
should be writable".

You should check its exit value for errors, though.
