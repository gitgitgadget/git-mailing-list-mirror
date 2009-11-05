From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of Pthreads
 API
Date: Thu, 05 Nov 2009 14:39:37 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0911051434090.10340@xanadu.home>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
 <1257439548-9258-1-git-send-email-ahaczewski@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, kusmabite@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Paolo Bonzini <bonzini@gnu.org>
To: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 20:40:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N68Bh-00049j-K5
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 20:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758793AbZKETjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 14:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758778AbZKETjz
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 14:39:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42100 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758750AbZKETjy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 14:39:54 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KSN007U5IM2L7U0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Nov 2009 14:39:38 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1257439548-9258-1-git-send-email-ahaczewski@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132239>

On Thu, 5 Nov 2009, Andrzej K. Haczewski wrote:

> +static unsigned __stdcall win32_start_routine(void *arg)
> +{
> +	pthread_t *thread = arg;
> +	thread->value = thread->start_routine(thread->arg);
> +	return 0;
> +}

I suppose you could reuse thread->arg for both the argument and the 
returned value to save a word.

> +int win32_pthread_join(pthread_t *thread, void **value_ptr)
> +{
> +	DWORD result = WaitForSingleObject((HANDLE)thread->handle, INFINITE);

Why are you casting thread->handle here?  Why not simply declaring it as 
a HANDLE?

Otherwise this looks pretty good now.


Nicolas
