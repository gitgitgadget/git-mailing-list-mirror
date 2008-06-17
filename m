From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Tue, 17 Jun 2008 16:04:25 +0200
Message-ID: <4857C469.1000401@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com> <m37icqpb5f.fsf@localhost.localdomain> <48568D5C.5090909@gmail.com> <7vy75580p1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 16:06:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8boF-0000Gr-Kx
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 16:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757832AbYFQOEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 10:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757573AbYFQOEX
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 10:04:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:62343 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757565AbYFQOEV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 10:04:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3553056fgg.17
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 07:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=Sm8qP4ViPiNjfZJWi7zFC71tOq9kP4YCEh++p8esGKk=;
        b=fTf0dTGJDLcPNx3e4IobxvM9GY+xTZ/+f4ZS+5ElF9e5/SzsM/gtXfGVih0T/AgPKu
         D67HBO0Mr3YS9tRxAFam85FvBA1DryFh+f7ciyCtkwDPPXhBqPLsoKxKCscVPiFzxLnR
         4HLom9dxZvppPxOk1Ux6TejEZCl1OuCCTdSVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=GsmtjzWAgpxMny5dmLg62Hs6i+TFuS//AGpWVq9MpYJ6tLdmwFiLkSfxqJDjjuoEpT
         GoKr3/7SdfHGkuGP18uJTLTynw9ohUcOo8xjpY4Kh6+F2VMCXDRif0odtNZGHrdvX+gL
         psH5x4zNU1Ek1xIRU5j/yutn1pkvkN4xiIC28=
Received: by 10.86.66.11 with SMTP id o11mr9127616fga.43.1213711460121;
        Tue, 17 Jun 2008 07:04:20 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.241.48])
        by mx.google.com with ESMTPS id e20sm13438584fga.1.2008.06.17.07.04.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 07:04:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vy75580p1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85298>

Junio C Hamano wrote:
> It's up to you to work on 'next' or 'master with extra patches'.

Okay; I guess I'll use 'next with extra patches'. ;-)

> [Gitweb's error handling:] isn't it possible for you to unconfuse
> yourself in a slow path and  figure out exactly why it failed?
> 
>         unless (open $fd, '-|', ls-tree $base -- $path) {
>                 # Oh, an error?  why?
>                 if (!object_exists($base)) {  [...]
>                 } elsif (!is_a_treeish($base)) {  [...]

That's possible, but the API I'm writing is designed the other way 
round: First, get the hash & type of $base; if it fails or the type is 
wrong, die accordingly.  Then pass the hash you got into whatever call 
to git, and if that fails, you can quite safely assume that something 
serious went wrong.  (The example above has an additional $path to deal 
with, but you get the idea.)

IOW, the strategy is "don't let the git binaries resolve any object 
names for you", which should make both error handling and caching a lot 
easier.

-- Lea
