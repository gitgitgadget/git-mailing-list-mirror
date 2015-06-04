From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP PATCH 11/11] Document protocol version 2
Date: Thu, 04 Jun 2015 10:01:12 -0700
Message-ID: <xmqq3827wgpz.fsf@gitster.dls.corp.google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-12-git-send-email-sbeller@google.com>
	<xmqqsiafazr7.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbELvZ6otnNwGHsgiC9EjgS2vrDGU2KCgF2c_Azm=-rWg@mail.gmail.com>
	<xmqqk2vraw6p.fsf@gitster.dls.corp.google.com>
	<20150529222120.GB15678@peff.net>
	<CAGZ79kaRTLX7eBCOA=yQHVwcN-H-o_aZFfQ1gw7Nx-NC82pbag@mail.gmail.com>
	<CAGZ79kYD--dZ_V=_X_Eo31KYTKXt2njuf56XqRRdaTJeLhDjaQ@mail.gmail.com>
	<20150604131852.GB12404@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 19:01:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0YWI-0000Yj-1j
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 19:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbbFDRBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 13:01:20 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35113 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937AbbFDRBP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 13:01:15 -0400
Received: by igbzc4 with SMTP id zc4so13491429igb.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5du2/z2kQJ+IVSCl5xDCMfN3lqcLmKVixdHGO8Amhzw=;
        b=mU5At4n1ZepA9kVPqBP1a7ko4qxiWUojlCgJCo8Hie/bNFYJlBzpOSG4nDlaXiZlxf
         YnS5pctutkK/fCyutAhtgvWHI6FQDeXNzSO4oFL7D84+LtFnfW30iGCz4W7Rihe2VcL5
         FCVd0uhCK2SqbmXqixCaWpE8DcZLHL3K1rDeGgSX/tb1+JPV//I0nWnUwlkUr/bAuIVy
         whc4nA3EDA8prk3aN7l4+BvENILsSqf3aug6t8SGMYIBKoQglAkaZMoixkvmjyPe8F3z
         3LXtV7o9if4mEtnU3geNGmiAaeoYnLCIXrUqd3BbTZUiYwk9F34gTwYfxC5yMusjjV/D
         9YJg==
X-Received: by 10.43.171.202 with SMTP id nv10mr5508665icc.30.1433437274782;
        Thu, 04 Jun 2015 10:01:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9816:1e41:550:d20e])
        by mx.google.com with ESMTPSA id o19sm1453503igi.14.2015.06.04.10.01.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 10:01:14 -0700 (PDT)
In-Reply-To: <20150604131852.GB12404@peff.net> (Jeff King's message of "Thu, 4
	Jun 2015 09:18:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270783>

Jeff King <peff@peff.net> writes:

> We should definitely _not_ add anything that scales with the repository
> size. For instance, the "symref" field only shows the "HEAD" now. That's
> OK, as it's constant size.

I agree that this is an easy-to-explain rule to keep the design
sensible.

> We do not show _all_ symrefs right now
> because of pkt-line length limitations. With v2, we could in theory
> start doing so (one per pkt-line). But that does not make it a good
> idea.

Very true.  If we want symref information conveyed, then we should
either make a new "symref advertisement" available (and it is OK to
use a single-bit capability to enable or disable that new section),
or make the "ref advertisement" natively capable of always doing so
(i.e. if there is no need to make this optional).
