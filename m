From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv6 16/16] Introduce portable_unset and use it to ensure
 proper && chaining
Date: Mon, 4 Oct 2010 06:38:38 -0500
Message-ID: <20101004113838.GF4738@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-17-git-send-email-newren@gmail.com>
 <AANLkTinU_fv7pJqw_ghM4RoF6dsiV8PFM3GgCqD-hh7L@mail.gmail.com>
 <20101004044402.GF24884@burratino>
 <7vy6ae8kdi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 13:42:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2jQd-0001i7-Nd
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 13:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950Ab0JDLly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 07:41:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62519 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab0JDLly (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 07:41:54 -0400
Received: by iwn5 with SMTP id 5so6817668iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yN32arhIxYwSNtFYQu2em4ejWRsLNGX1N/uaMf3f8T8=;
        b=mz3F17aADWuYKu6LehNREs7sueE7aiPUnBSLI1qzNotB+otAd5TnUv+qzkwXax+lia
         mRZBd+WlkAZrRUMUzwQThkyhf0TwGHf13zxggPC4CMizBtDkhW3YnNYmv6Ppi3sZI9FW
         ULzTcXuMvqOdokq6yLv+LsMJLwz8FEWEi4ny8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LjxRNzzGXZxIdEBmNMrzc0l4warSk4poglUlmiRIyawB492EdHrADIWoCo/hMjnGrW
         yjexflSMkS4/sdIR4nbdAP6lO7I/FFLGYFBpsXJppQ+b85MURGNoMIEt7ZLWLmkB3TWp
         HFJPfyT4aV0IKZU5k6mh7NELRZ2f41xtCSvG0=
Received: by 10.231.59.13 with SMTP id j13mr10064724ibh.77.1286192513550;
        Mon, 04 Oct 2010 04:41:53 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id d13sm2988472ibb.2.2010.10.04.04.41.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 04:41:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vy6ae8kdi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158034>

Junio C Hamano wrote:

> Hmm, the pros and cons between allowing test_might_fail on normal commands
> vs introducing cmd_might_fail are questionable, though.  I cannot think of
> a case where we would want to tolerate death by signal or segv on non git
> commands

Okay, makes sense.  I would be happier if exit statuses 129 and 129-256
were disallowed by test_must_fail, too, but that does not make it any
less useful for cases like "test_might_fail grep needle haystack >result".
And it is better to avoid introducing yet another command to learn.
