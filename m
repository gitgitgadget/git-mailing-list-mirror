From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 04/73] Makefile: "pot" target to extract messages
 marked for translation
Date: Fri, 25 Feb 2011 16:11:39 -0600
Message-ID: <20110225221139.GE4580@elie>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-5-git-send-email-avarab@gmail.com>
 <20110225072212.GC23037@elie>
 <AANLkTim72p3H5zrELsApN8EM1CAU1H=FdjaoL+s=cJzH@mail.gmail.com>
 <20110225212010.GC4580@elie>
 <7vsjvb94p6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 23:11:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt5tA-0002uX-Jm
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 23:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932955Ab1BYWLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 17:11:50 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33174 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140Ab1BYWLs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 17:11:48 -0500
Received: by vxi39 with SMTP id 39so1796405vxi.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 14:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JQX0PBCCWZHVgHYEgSDr1Rsupfi/agLIZuhPhFRK8m8=;
        b=dhwDQdp7iurUGbkxCYGOPdrljPms0EKpv2allc2ryOF76KgfTO2encN8v19TcPM8Mt
         ZVUpD4l/wqPVs/dy64rHvpVESq13EpNwDUJgjNyWmmjX9PXp9g/mcfAKE/fYFu3ER3vU
         CztRggoLWsT462bnVV4AdN2/qkIVBDfIJxQuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dCqHD1xSakaawxLNPdbujFRYiPL78nkpH3tKDZ+jVxwTsElcsnxntSrIxIypykQK9q
         zBwkcmg3DrMtRC+HetxEUT2wu6pbqeLA8Si+S1C0UoPC2sXU8x05IIIQfH3EOBjshs1Z
         J5K0a6l8FnyBfbSZChID5QaDh7B5/F0Zk2yAY=
Received: by 10.220.177.198 with SMTP id bj6mr98090vcb.214.1298671907316;
        Fri, 25 Feb 2011 14:11:47 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id u4sm583836vch.12.2011.02.25.14.11.44
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 14:11:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vsjvb94p6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167948>

Junio C Hamano wrote:

> Does xgettext leave output file specified with -o when it gets killed?

I don't think so.  But xgettext collects output and then writes it all
in one swoop, so it's hard to provoke problems that way in practice.

The possibility that had me worried is what hat happens when we start
translating shell scripts:

	xgettext -o$@ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
	xgettext -o$@ --add-missing $(XGETTEXT_FLAGS_SH) $(LOCALIZED_SH)
	xgettext -o$@ --add-missing $(XGETTEXT_FLAGS_PERL) $(LOCALIZED_PERL)

If the build is interrupted partway through, the output from the
commands that succeeded will remain and leave out the messages that
would have been added later out of the template.
