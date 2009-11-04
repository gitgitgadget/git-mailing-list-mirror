From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] MSVC: port pthread code to native Windows threads
Date: Wed, 4 Nov 2009 15:43:01 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911041406101.14365@iabervon.org>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>  <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>  <4AF175E8.7020400@viscovery.net>  <16cee31f0911040547m69e5b9cbi30e20d2a7790bd6f@mail.gmail.com>  <4AF190F1.3020607@viscovery.net>
 <16cee31f0911040650s3eba1067mb66a48bb50c97c28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:43:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5mhB-0001MG-S5
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 21:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbZKDUm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 15:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbZKDUm5
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 15:42:57 -0500
Received: from iabervon.org ([66.92.72.58]:43705 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932347AbZKDUm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 15:42:57 -0500
Received: (qmail 30239 invoked by uid 1000); 4 Nov 2009 20:43:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2009 20:43:01 -0000
In-Reply-To: <16cee31f0911040650s3eba1067mb66a48bb50c97c28@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132145>

On Wed, 4 Nov 2009, Andrzej K. Haczewski wrote:

> 2009/11/4 Johannes Sixt <j.sixt@viscovery.net>:
> >
> > You are right. But #ifdef THREADED_DELTA_SEARCH is about a "generic"
> > property of the code and is already used elsewhere in the file, whereas
> > #ifdef WIN32 would be new and is is about platform differences.
> >
> > Anyway, we would have to see what Junio says about the new function calls,
> > because he's usually quite anal when it comes to added code vs. static
> > initialization. ;)
> 
> I could do it with wrappers for pthread_mutex_lock and _unlock and
> lazy init there plus lazy init cond var in cond_wait and _signal, that
> way it could be done without any additional code in the first #ifdef.
> But I don't see any simple solution for working around
> deinitialization, that's why I'd leave non-static initialization. Let
> me put some touchups and resubmit for another round.

Is it actually necessary to deinitialize? Since the variables are static 
and therefore can't leak, and would presumably not need to be 
reinitialized differently if they were used again, I think they should be 
able to just stay. If Windows is unhappy about processes still having 
locks initialized at exit, I suppose we could go through and destroy all 
our mutexes and conds at cleanup time. Pthreads does have the appropriate 
functions, and it would be correct to use them, although unnecessary.

	-Daniel
*This .sig left intentionally blank*
