From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] config.c: rewrite ENODEV into EISDIR when mmap fails
Date: Thu, 28 May 2015 14:11:55 -0700
Message-ID: <xmqqr3q0flus.fsf@gitster.dls.corp.google.com>
References: <20150528075142.GB3688@peff.net> <20150528080300.GD23395@peff.net>
	<xmqq7frsiq3o.fsf@gitster.dls.corp.google.com>
	<20150528204436.GB29148@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jorge <griffin@gmx.es>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 28 23:12:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy560-00014I-RC
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 23:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbbE1VMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 17:12:01 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:34716 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932321AbbE1VL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 17:11:57 -0400
Received: by ieczm2 with SMTP id zm2so48569953iec.1
        for <git@vger.kernel.org>; Thu, 28 May 2015 14:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9InjQqUfmo4VUGwvfsIv2qV4uBppKVlJlXsMd83Mw+w=;
        b=JxfnKf0ihe7cEpeUOgPHGd4uH7PthrMCWjxzVYgRg/73WGuO52Vq/CcAaQNu82wECq
         BvWa4Q1kUvoW45EnrytcRZwvSC8gz1JXDiL/4ApEfDij0y0y4O0mL/SceVHT0nurpvyW
         sjz6NT8pddVU614+uUqxDN1OoF4LFcPzk6cVSFPyRFc6E2P8Mdx+q1ja9KQV6e0NTqV+
         tliZ174lgqkcdUIrWbPeX6r0h+cpxLXDX1NIKniiOM569R9mDG5LZJqW7HO1+7o9Vlce
         YHR2UHxEI9CR2eOw/0GDHVbsO2vW3izQc2QgSJQ0bO1rUeapFfuRKsZBqMK265GH33jM
         D9mQ==
X-Received: by 10.50.117.106 with SMTP id kd10mr17140438igb.24.1432847517081;
        Thu, 28 May 2015 14:11:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id y124sm2649576iod.13.2015.05.28.14.11.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 14:11:56 -0700 (PDT)
In-Reply-To: <20150528204436.GB29148@peff.net> (Jeff King's message of "Thu,
	28 May 2015 16:44:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270199>

Jeff King <peff@peff.net> writes:

> We also know S_ISDIR(st.st_mode) _before_ we actually mmap. So I was
> tempted to simply check it beforehand, under the assumption that the
> mmap cannot possibly work if we have a directory. But by doing it in the
> error code path, then we _know_ we are not affecting the outcome, only
> the error message. :)

Well, even if your mmap() worked on a directory, having ~/.gitconfig
as a directory is wrong in the first place, so...

I think what you sent is good as-is, so let's go with them.
