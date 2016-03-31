From: Marios Titas <redneb@gmx.com>
Subject: Re: [PATCH 1/2] ident: check for useConfigOnly before auto-detection
 of name/email
Date: Thu, 31 Mar 2016 18:01:09 +0300
Message-ID: <20160331150109.GA7235@zeno>
References: <1459366183-15451-1-git-send-email-redneb@gmx.com>
 <20160331144003.GE31116@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 17:01:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ale6F-0003fr-SV
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 17:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757153AbcCaPBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 11:01:22 -0400
Received: from mout.gmx.net ([212.227.17.22]:56371 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757067AbcCaPBU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 11:01:20 -0400
Received: from localhost.localdomain ([79.103.155.63]) by mail.gmx.com
 (mrgmx103) with ESMTPSA (Nemesis) id 0M2L60-1ZtxXy257E-00s8Fk; Thu, 31 Mar
 2016 17:01:14 +0200
Content-Disposition: inline
In-Reply-To: <20160331144003.GE31116@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Provags-ID: V03:K0:UASPj8l0xQqjKTduIkqfB3ucRUtEoBQHckuGjWpTFUm1UCLnBWl
 X8YvC2bgBXOMC8enlKgTVwahbGK5duWsOMQx7y0SM1Zgul1TLw3ckLnSbuwRzXEISszKKeS
 tUnEIOVD3XYhd9Xo4Elc93IrRZZ1P//s0mWGezWhWgiIctdu/N9tQ5MdZf+kwMOBl8Nz7rZ
 n2c+Kjc1PIza9/YrA6wWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kwQyndxZnI8=:oDlSTFZVD8GDZfOWkCo6kE
 AciB6AxsuJ1NhnZvE+4u/kj32EPczICvFD9cxQm190RQ/q9cuueWR8nD6o16SbeiXNwl7n621
 yvw+qkHlsuFxjMUpnyBFNzpRmjsFFqSBKsCc3RyoqWAdyTSMrvsJYfeS+TAU4ZiT/UOgys6lE
 TybIxgZQq/h/FKosOpuoqgey9ANekSQWN1rPGWp+RUXlebnX/X94AquGQ1Jzov79RNmAl/iJ1
 TFQEubObtxAxvrbOQwLkvDCqraJLjr8ve6PMM4g07rqRZoYNZAKSXVwe8K2VrxLLVf9+BTZ/n
 i+P7XsuaGWX6dNkEvNIPMFnhIMumjqu7SVJwxIrEv408W6RKgDD5JGRKEBHAg/BxFl6MgUfGt
 r/Q1j9FoFyrT39PMUO3RNT2ug41SrPnHzzB1nqZ3q5vcr9SmuTN0UJih+NFzHHPu1d7tBXrni
 8d6su9adphA7o51qfqhqv/wOBeOJyryDwTjDMbNWjBms6pLV+gGDsxsRo+yyYV1SU4jaNZwxT
 u8tlNeh8b2H63LB3DF63acKjtaIPa3WoSD/1Iggw6y5SZsqU/GRSdC3GI+jVG7Q5cg5707z+8
 6wTV8bxk7bPWDoL9Einu5Vn89ED1zzrIUcahsfNYcVXlBZ0RD0eORPPo7YIIx5IxgPcN6eYxt
 CiLxkG4VG23ijjTc7P0+CsrJ8zeNn9gYU4Zfxk9dfO9AGcILQtQ3OxOdXh5xSRh4+rfxVl0P9
 WblwNHdWLZiAD7i3a6ZuBuZybLA4ETSXGH/uboEiIXm+9DdTtfD4YsYUTis=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290397>

On Thu, Mar 31, 2016 at 10:40:03AM -0400, Jeff King wrote:
>On Wed, Mar 30, 2016 at 10:29:42PM +0300, Marios Titas wrote:
>
>> If user.useConfigOnly is set, it does not make sense to try to
>> auto-detect the name and/or the email. So it's better to do the
>> useConfigOnly checks first.
>
>It might be nice to explain how it is better here. I'd guess it is
>because we may fail during xgetpwuid(), giving a message that is much
>less informative?

Oops sorry, my bad, I should have included an example in the commit 
message. So with git 2.8.0, if you provide a name and set useConfigOnly 
to true in your ~/.gitconfig file, then if try to commit something in a 
new git repo, it will fail with the following message:

    *** Please tell me who you are.
    
    Run
    
      git config --global user.email "you@example.com"
      git config --global user.name "Your Name"
    
    to set your account's default identity.
    Omit --global to set the identity only in this repository.
    
    fatal: unable to auto-detect email address (got 'XXX@YYY.(none)')

(provided of course that auto-detection of email fails). This wrong, 
because auto-detection is disabled anyway.
