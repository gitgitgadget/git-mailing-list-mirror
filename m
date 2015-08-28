From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-email and IPv6-only host
Date: Fri, 28 Aug 2015 10:19:09 -0700
Message-ID: <xmqqbndr2uwi.fsf@gitster.mtv.corp.google.com>
References: <20150828041119.GP301234@dakara>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?St=C3=A9phane?= Graber <stgraber@stgraber.org>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:19:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVNJ7-000326-SP
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 19:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbbH1RTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2015 13:19:13 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36630 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbbH1RTL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 13:19:11 -0400
Received: by padhm10 with SMTP id hm10so13003659pad.3
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=wtoUehy3Cs/rAMbS1Giwa8NLh/jRvtYc0pcTYSeeyno=;
        b=xBini8ZFPG7Vg6ERLODhWqa0Pc9jPdmeJox/NQaa2x5Fqb6xjohx/e+ty05zTgihrT
         8cXVf8VkVT4/Xg91IsbasGbj3AWL6fPfbz7getGhZuEenOXk/GqgD1nVmIyUB3KXMDoj
         xgBt736jV461JVqIltu0hvt9RAoI3UaUs/47NjI+rzZemN+9U0cs6a4UJuioepGlIDxh
         RWotZ81LwbFPWEyuDjqeQl0VIXVMEHxtQf2vpet4hfScl1Jlaro0kF3DM5ZU3BJYEKj7
         KL62909vHR290nrWLX4p/mTbqg+qvyMuWwQMTwlKjp8LoLiMRh++XLr9qru5ZIUHKYt2
         IBJA==
X-Received: by 10.68.109.34 with SMTP id hp2mr16669233pbb.52.1440782350805;
        Fri, 28 Aug 2015 10:19:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id cy10sm6347156pdb.13.2015.08.28.10.19.10
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 28 Aug 2015 10:19:10 -0700 (PDT)
In-Reply-To: <20150828041119.GP301234@dakara> (=?utf-8?Q?=22St=C3=A9phane?=
 Graber"'s message of
	"Fri, 28 Aug 2015 00:11:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276736>

St=C3=A9phane Graber <stgraber@stgraber.org> writes:

> Hello,
>
> I've recently switched my home network to be IPv6-only, using NAT64 a=
nd
> DNS64 to reach IPv4 hosts. Pretty much everything I use day to day ju=
st
> kept on working fine, but I keep finding some small problems here and
> there, mostly to do with perl software.
>
> One of those is git-send-email which isn't capable of talking to an I=
Pv6
> SMTP server.
>
> I've locally patched my git-send-email to add:
>
>     require Net::INET6Glue::INET_is_INET6;
>
> This seems to be the magic bullet for all IPv6 problems I've had with
> perl software, though I'm not sure whether this is an acceptable fix
> upstream as this does bring an additional dependency to git-send-emai=
l.

I wonder what happens if you 'require' that Glue on a host that is
not IPv6-only.

What I am trying to get at is if what that Glue thing does is an
acceptable thing to do in the Net::* Perl modules (e.g. Net::SMTP
and Net::SMTP::SSL that we use), i.e., what INET6Glue does to work
around issues in Net::* is a problem Net::* Perl modules should be
solving for the users of these modules.

After all, it is madness to ask all packages that use Net::*
infrastructure, like git-send-email, to 'require' an extra module.

Thanks.
