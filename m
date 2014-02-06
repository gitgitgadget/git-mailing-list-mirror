From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] check-attr: move to the top of working tree when in non-bare repository
Date: Thu, 06 Feb 2014 12:32:31 -0800
Message-ID: <xmqqr47gx9r4.fsf@gitster.dls.corp.google.com>
References: <xmqqvbwsyvn8.fsf@gitster.dls.corp.google.com>
	<1391712033-9443-1-git-send-email-gitster@pobox.com>
	<1391712033-9443-2-git-send-email-gitster@pobox.com>
	<20140206195310.GV30398@google.com>
	<20140206201743.GW30398@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lasse Makholm <lasse.makholm@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 21:32:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBVcm-0005oA-ES
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 21:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbaBFUcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 15:32:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59167 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbaBFUcf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 15:32:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27CCB6AA99;
	Thu,  6 Feb 2014 15:32:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RZGQaagayI4mnvmd1ASReouB0Z0=; b=hzL0Sp
	tEvRaHsCc5PK/dcDSK0h530bAjEA4gPqDdYC5fri4ImrG2mrSbHnSlbXO4JAxbDz
	cNfewbCq/L3D7dbqlgxzkAIP+D4iJcdEbyPlHfJlU221k3p+OePOlKlAmw2xc6H3
	2k00YsjHK2ndWp+0p0tJrpptzqn10+dtzHdxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZpRkH2nn4nWfcJ4niQj8OoEM6FiiOzFS
	30/7zcO//kAjzfU2zQ3hL8yfvS8SMmaCvAXX/xUUMuGEB1PfqbZ4ai5okKFhkEMW
	g1GmMXRdqrUNDDtlhkcGBAQiK2LxBluwScOST7Px08HVVSMVGk6SN4uw/wjmNHwT
	YpKIRw/sZMs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E65C6AA98;
	Thu,  6 Feb 2014 15:32:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02A1D6AA94;
	Thu,  6 Feb 2014 15:32:33 -0500 (EST)
In-Reply-To: <20140206201743.GW30398@google.com> (Jonathan Nieder's message of
	"Thu, 6 Feb 2014 12:17:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CF1C8C64-8F6D-11E3-8335-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241743>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Someone asked in a private reply how this interacts with t0003.

It was me mistakenly using "reply" not "reply all".

> t0003 tries check-attr in a bare repository.  The question is, is that
> a desirable feature, and are people relying on it?

Running tar-tree from a public distribution point comes to mind.
bootstrap-attr-stack seems to have reference to is-bare-repository
to validate the attribute direction to read from the index, but I
tend to think what it really wants is to read from HEAD not the
index.

> How do I use the only-look-at-HEAD mode from a non-bare repo?

Is "You don't" a good answer?

Use of --cached when your index matches HEAD is the equivalent, and
if the index differs from HEAD, you must have had a reason to add
that change to .gitattributes to the index, so I think it is
reasonable to honour that change.
