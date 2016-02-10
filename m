From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Wed, 10 Feb 2016 13:07:43 -0800
Message-ID: <xmqqd1s4z334.fsf@gitster.mtv.corp.google.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
	<CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
	<CAGZ79kZMvxa5Np4GbShv_A6NZwVAqff94+d8MFTZwrZS+2CqeQ@mail.gmail.com>
	<20160210210115.GA10155@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 22:07:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTbzK-0004xF-Am
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 22:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbcBJVHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 16:07:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750770AbcBJVHp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 16:07:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 00CF844950;
	Wed, 10 Feb 2016 16:07:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3nfcfJej3NjGDD+FA8hEFgo6i/0=; b=pzbqF7
	EVVtYVCV21KLLKZSMJow3CnWL4Bgyp7aTscxDLgOI//oIEcfmqrtSgc8l+s8bG4U
	4ogSl5EEbL2s5nGgToIT6u/nWPZ0mQbAsuQhNKjbgtI0hdHFltgO2lKFVD1VUB/4
	uCM3uBlRiFV2zBAosxFcVLys53VRpBsAbzYjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KJwOUVgnY1HR5EJ1tV9s4o+jfquyIA1/
	Sa+NBjWUqyjjWeGJ767vXF8HWdJdknnHDl5etBhAWmUIEYbcfRGdNK5V8kCIwhg2
	QvzdmX3UG1BUVQGX1v01kTOxn/qEyB6Dpr2lLgWJ1IpY+1egb1DkKzDkIF8tuA3J
	aJo6C22WMwg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA31A4494E;
	Wed, 10 Feb 2016 16:07:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6EE884494A;
	Wed, 10 Feb 2016 16:07:44 -0500 (EST)
In-Reply-To: <20160210210115.GA10155@google.com> (Jonathan Nieder's message of
	"Wed, 10 Feb 2016 13:01:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 543E3122-D03A-11E5-BBB3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285927>

Jonathan Nieder <jrnieder@gmail.com> writes:

> --strict + --check-self-contained-and-connected check that the pack
> is self-contained.  In the process they mark each object that is
> reachable from another object in the pack with FLAG_LINK.
>
> The objects not marked with FLAG_LINK are the roots.

Ahh, OK, if we already have the code that does it, I have no
objection.  At some point before finalizing the pack on the disk we
would want to run fsck on all objects anyway, so having to pass
"--strict" to find objects that lack FLAG_LINK does not sound too
big a downside.

Thanks.
