From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 17:15:59 -0500
Message-ID: <4B0DAC9F.2010205@gmail.com>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org> <20091125203922.GA18487@coredump.intra.peff.net> <7viqcytjic.fsf@alter.siamese.dyndns.org> <20091125210034.GC18487@coredump.intra.peff.net> <7vmy2as319.fsf@alter.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 23:16:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQAL-0002SO-HI
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 23:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935167AbZKYWQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 17:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935165AbZKYWP7
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 17:15:59 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:52908 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759436AbZKYWP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 17:15:58 -0500
Received: by gxk26 with SMTP id 26so159286gxk.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 14:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=H8SFzl78WpbfwE3GF2719aQ0sjBg/r2TW63MdLLHvVI=;
        b=toYp7ItsV+U+gLEcQWB9Xa//IAd9me0nNqSx0ZathajEWf0ovgBlmVdDUsVPCfLPT3
         v/M9pkDwUlAjaek+ammGdmZ4fAn56tV2xcKIn/opXVqSox4MGfcqTfTV7xZ0B2u3CzLw
         iSfEQg1zIf2p06UeLUHIjEYsu2PGToA3I9ecc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=bQt4sfnzbf/xs6mhwYJ5XVVOYehFP3ZX4WdXt+JC2aZACqLDh51EypWqNJ5D2udGUL
         phHEy2ehMHrUwCnZXMrEYpRzbo3xwaoi73l92prC5rD8wy2hoOkHQcQKNXngJMysuBQO
         Ii4tr42RHDJLjZJhQfiyP8BZeMxMIFcAn4QQw=
Received: by 10.150.45.35 with SMTP id s35mr14595929ybs.129.1259187364229;
        Wed, 25 Nov 2009 14:16:04 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 6sm32654ywd.52.2009.11.25.14.16.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 14:16:03 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7vmy2as319.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133682>

Junio C Hamano wrote:
 > Jeff King <peff@peff.net> writes:
 >
 >> On Wed, Nov 25, 2009 at 12:52:11PM -0800, Junio C Hamano wrote:
 >>
 >>> So I think the posted patch alone without changing anything else 
would be
 >>> the approach to give the most benefit with the least impact to existing
 >>> users, at least for now.
 >> Yes, I meant to say in my original message but forgot to: I think
 >> --full-tree is an important first step, no matter what happens next. It
 >> gives people a way to do what they want without typing the right number
 >> of ".."s, and it opens up --no-full-tree if the default changes later.
 >>
 >> But I do worry about it being a command-line option. You are asking the
 >> user to remember to type --full-tree every time.
 >
 > We could redefine get_pathspec() to treat a pathspec that begins with a
 > slash to be anchored at the top, i.e.
 >
 > 	$ git grep -e frotz /
 >
 > would be a nicer way to spell
 >
 > 	$ git grep --full-tree -e frotz
 >
 > and allows you more than what you can do with --full-tree, e.g.
 >
 > 	$ cd linux/subtree/some/very/deep/subdir/you/do/not/remember/exactly
 > 	$ git grep -e frotz /linux/subtree
 >
 > If we do that, it will not be limited to "grep" but would bring 
uniformity
 > to the command set [*1*].  Of course, you can keep doing
 >
 > 	$ cd t
 > 	$ git grep -e frotz .
 >
 > to look inside only the current directory, and once this new 
convention is
 > accepted and widely used, it would become possible to flip the default
 > without causing too much pain (yes, I am agreeing with you that this 
is an
 > important first step).
 >
 > Once there is a convenient and uniform way to ask for either 
behaviour, no
 > matter what the default is, the scripts that want specific behaviour can
 > be updated to choose whichever they want, given enough time (say, 2.0.0).
 >

Speaking as a `grep' user: having git-grep behave radically different 
than normal grep would be/is very annoying [*1*].

Speaking as a `git' user: having the different git commands use 
radically different path conventions, relative to other git commands, 
would be/is very annoying [*1*].

To make the reconciliation  even more difficult, some git commands will 
also work on out-of-tree paths.

Footnotes:
[*1*] And surprising to new/occasional git users.
