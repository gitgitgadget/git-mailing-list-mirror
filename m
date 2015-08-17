From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 4/4] notes: teach git-notes about notes.<ref>.mergestrategy option
Date: Mon, 17 Aug 2015 10:33:35 -0700
Message-ID: <xmqqlhd9es5s.fsf@gitster.dls.corp.google.com>
References: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
	<1439586835-15712-5-git-send-email-jacob.e.keller@intel.com>
	<xmqq8u9dh6lq.fsf@gitster.dls.corp.google.com>
	<CAPig+cTxmFCRChzahQZVpMeJ=3N0PjHAcamFBm394OgTR8LnLw@mail.gmail.com>
	<CA+P7+xofitJ2tTxqtRyWitcSKt4sKZCH5tygJxXScuW8wkW=SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:33:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZROI1-0000iw-TG
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 19:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbbHQRdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 13:33:37 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:32953 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbbHQRdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 13:33:36 -0400
Received: by pdrh1 with SMTP id h1so58628224pdr.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=b7TJ8TBy/8zQ3veYEsD6SF1yD7fBQHp5s0re535h8Kg=;
        b=yrrM11HMLDsJVAJQ1F8Dj3Cpm1O4bLJn5Lf3y5pzMyXCbomXtwhpJ0lR0/PhBSTRui
         Tj4Om40HPmRpFZJbt6P1v7GQ4KjbLdYBw3+bPM4byfx1ZzziJa46XWY1HDQzXqwJxdWa
         U6STk3GaOn3yBScrBhEZfz0uCDmzSyER8IQ31Rp0YzulfyzIyZRAx15tlwbSXouprY5q
         iRHRV0pCOEfo4voqneVXzre5IuVVO+VPIgJrxRkd0IhPJwtJxkBql1xy+CxE9ZiqLdhz
         lkp0Kc1WR54mG5iva7rR7pmeHgMNM5E78WcJpwm2wDGX1lwooV6iVSL5O3rJ4EggyICf
         dKwA==
X-Received: by 10.70.39.74 with SMTP id n10mr4667840pdk.57.1439832816376;
        Mon, 17 Aug 2015 10:33:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id y8sm7569667pbt.7.2015.08.17.10.33.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 10:33:35 -0700 (PDT)
In-Reply-To: <CA+P7+xofitJ2tTxqtRyWitcSKt4sKZCH5tygJxXScuW8wkW=SA@mail.gmail.com>
	(Jacob Keller's message of "Fri, 14 Aug 2015 15:50:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276062>

Jacob Keller <jacob.keller@gmail.com> writes:

> How do you feel about having the duplicate check for the short_ref? We
> *already* check this inside init_notes_check() which is called right
> after this.

I thought you were trying to enforce a new rule (i.e. must be under
"refs/notes/") with this, but it isn't.  It is "we are going to
strip the prefix known to us, just make sure the caller did not feed
us something bogus" safety, and the placement of this new check in
your patch (i.e. only when strategy was not given so we need to
check which short-ref we are dealing with) is the best place.

Thanks.
