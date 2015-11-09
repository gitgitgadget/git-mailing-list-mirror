From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH v4] Add git-grep threads param
Date: Mon, 9 Nov 2015 08:34:27 -0800
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA17@mail.accesssoftek.com>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
 <xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>
 <20151104064021.GB16605@sigill.intra.peff.net>
 <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA15@mail.accesssoftek.com>,<20151109155538.GC27224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"john@keeping.me.uk" <john@keeping.me.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 09 17:34:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvpOs-00051e-7Z
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 17:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbbKIQea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 11:34:30 -0500
Received: from mail.accesssoftek.com ([12.202.173.171]:30269 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbbKIQe3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 11:34:29 -0500
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Mon, 9 Nov 2015 08:34:28 -0800
Thread-Topic: [PATCH v4] Add git-grep threads param
Thread-Index: AdEbBxW9fXSEVlExTRCMfMOP6y8C5wAA3kgu
In-Reply-To: <20151109155538.GC27224@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281055>

> Why don't we leave it at 8, then? That's the conservative choice, and
> once we have --threads, people can easily experiment with different
> values and we can follow-up with a change to the default if need be.

I'd propose the following:

    if (list.nr || cached) {                                                                                            
        num_threads = 0; /* Can not multi-thread object lookup */                                                       
    }                                                                                                                   
    else if (num_threads < 0 && online_cpus() <= 1) {                                                                   
        num_threads = 0; /* User didn't set threading option and we have <= 1 of hardware cores */                      
    }                                                                                                                   
    else if (num_threads == 0) {                                                                                        
        num_threads = GREP_NUM_THREADS_DEFAULT; /* User explicitly choose default behavior */                           
    }                                                                                                                   
    else if (num_threads < 0) {  /* Actually this one should be checked earlier so no need to double check here */                                                                                       
        die(_("Ivalid number of threads specified (%d)"), num_threads)                                                  
    }     

--
Victor
