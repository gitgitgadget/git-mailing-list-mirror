From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Wed, 20 May 2015 10:25:41 -0700
Message-ID: <xmqqr3qbnotm.fsf@gitster.dls.corp.google.com>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
	<1431806796-28902-1-git-send-email-gjthill@gmail.com>
	<xmqqegmfds1n.fsf@gitster.dls.corp.google.com>
	<xmqqvbfrc952.fsf@gitster.dls.corp.google.com>
	<20150519063716.GA22771@peff.net>
	<xmqqk2w48mjp.fsf@gitster.dls.corp.google.com>
	<20150519220918.GA779@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jim Hill <gjthill@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 20 19:25:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv7kb-0003UQ-B6
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 19:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbbETRZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 13:25:45 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36867 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbbETRZo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 13:25:44 -0400
Received: by igbsb11 with SMTP id sb11so45409170igb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=uIhg9CyiEXbRSJKc1bfsD4Gc6orLoUneLX/PeSVPhbw=;
        b=d/Qe+KE4bJ0aIUgJ9gQGQgJDissl3qdR/g1nlwUWBIoPf3jmd7AIp1PB4SqrfFx9lz
         bA3QxYs5DbM4IcWWH6AZeGs3HjOGoK/pUoZqNyq75b+GH+gZrdkdKhDE2MuEOIBndNPQ
         v16wJlu3rqyzj/ZBWyxNd7UC1CoBC/bN/dA08xS3WmUPkmBD9MP0u3pV+/phPz755dJ0
         gihRK2Vv6VkFak6RNjjOLin+lPxKnphLlbTLVA/neSMQZHXuou3tUl64xcB6nrmy6WW+
         bhuBzBhne/L95ljNBid8e003dr6qL8qKRIPZPysYUIXJSdQ65uFP8znE4JEf4aLQ5Fs4
         k2qA==
X-Received: by 10.107.128.30 with SMTP id b30mr16192166iod.84.1432142743637;
        Wed, 20 May 2015 10:25:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id y124sm12809927iod.13.2015.05.20.10.25.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 10:25:43 -0700 (PDT)
In-Reply-To: <20150519220918.GA779@peff.net> (Jeff King's message of "Tue, 19
	May 2015 18:09:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269480>

Jeff King <peff@peff.net> writes:

> Not related to your patch, but I've often wondered if we can just get
> rid of hold_lock_file_for_append. There's exactly one caller, and I
> think it is doing the wrong thing. It is add_to_alternates_file(), but
> shouldn't it probably read the existing lines to make sure it is not
> adding a duplicate? IOW, I think hold_lock_file_for_append is a
> fundamentally bad interface, because almost nobody truly wants to _just_
> append.

Yeah, I tend to agree.  Perhaps I should throw it into the list of
low hanging fruits (aka lmgtfy:"git blame leftover bits") and see if
anybody bites ;-)
