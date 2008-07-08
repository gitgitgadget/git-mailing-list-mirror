From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] fix "git-submodule add a/b/c/repository"
Date: Tue, 08 Jul 2008 19:57:43 -0400
Message-ID: <4873FEF7.7000005@gmail.com>
References: <20080701150025.GD5852@joyeux> <7vd4lro7ct.fsf@gitster.siamese.dyndns.org> <20080706161101.GB23385@jhaampe.org> <48711782.6090609@gmail.com> <20080707063424.GB5506@jhaampe.org> <4872CF86.5050702@gmail.com> <7v7ibxxfje.fsf@gitster.siamese.dyndns.org> <4872DE54.5010804@gmail.com> <7vhcb0x6ak.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sylvain Joyeux <sylvain.joyeux@dfki.de>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 01:58:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGN54-00015b-V6
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 01:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbYGHX5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 19:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041AbYGHX5s
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 19:57:48 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:51016 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010AbYGHX5s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 19:57:48 -0400
Received: by yx-out-2324.google.com with SMTP id 8so717937yxm.1
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=9izwlpI0CtVXWFqnBldoH0aFRgolb91CWCba9hZcNq0=;
        b=dn3Q52SZsZ1vBfTpOfxuOtnGNaK3Lhq2WQ0D/eVLR/E1PuESZS54CirlNZXiKG7z8d
         4586pqrIgE71sUTqA0xpqbRc2Zo4wL0SFrhfg1+su4nD/LTZUGkGqnTInVl026o4cabz
         zT1IZWWqVpEk3M7dpPO3GzXvk9jgkN8tRqZTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Xn3L67RKGt8VqZNdoa+r2qZUq8jkAxjh2HNBiMnM0dRUnKTcK0sC27navJvxoA2Yqf
         gQsnw9pPBBkgwbmkzQQIcrZKr1oQbTZb/b7IAmwKq/SKWS3PXCf5LSb31HdWWXslSx90
         KUqszyFZG4Q04AqJ6bUlv5bzSxivvanF8dn5Y=
Received: by 10.151.143.3 with SMTP id v3mr11214068ybn.244.1215561467179;
        Tue, 08 Jul 2008 16:57:47 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.246.235.165])
        by mx.google.com with ESMTPS id 8sm7943228ywg.6.2008.07.08.16.57.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jul 2008 16:57:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <7vhcb0x6ak.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87813>

Junio C Hamano wrote:
> Thanks.
>
> The above is quite a bit more information than I can read from
> Documentation/git-submodule.txt; care to send it in in a patch form?
>
>   
Will do, but I think it makes more sense to clean things up a bit so 
they are more explicable:

1) *require* two arguments for add: <URL> <relative-path-in-repo>
2) Remove one option for URL. Currently, we accept:
    a) absolute URL : origin is at URL
    b) top-level-relative URL (./foo | ../foo) : locates origin relative 
to top-level origin
    c) path-relative URL : locates origin relative to current working 
directory

I don't understand the use-case for item (c), and in any case it is 
easily replaced as an abolute url (e.g., $(pwd)/URL). So, I propose to 
restrict to (a) or (b) only, and reject (c).

I think these two changes in concert will reduce a lot of confusion 
without removing any real capability. Absent negative comments, I will 
prepare a patch to do this, *and* update the documentation to better 
define the options.

Mark
