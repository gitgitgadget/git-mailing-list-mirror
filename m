From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Fix gcc-4 warning in accept() call
Date: Thu, 29 Sep 2005 19:11:35 -0400
Message-ID: <200509292311.j8TNBZDm022135@inti.inf.utfsm.cl>
References: <proski@gnu.org>
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 30 01:39:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EL7zh-0006We-Et
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 01:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbVI2XjJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 19:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVI2XjI
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 19:39:08 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51380 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751375AbVI2XjI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 19:39:08 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j8TNBZDm022135;
	Thu, 29 Sep 2005 19:11:36 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: Message from Pavel Roskin <proski@gnu.org> 
   of "Thu, 29 Sep 2005 17:05:01 -0400." <1128027901.24397.57.camel@dv> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9526>

Pavel Roskin <proski@gnu.org> wrote:
> Fix gcc-4 warning in accept() call
> 
> gcc-4 warns about sign mismatch in pointers.  Third argument in accept()
> is socklen_t, which is unsigned.  Since Linus doesn't like socklen_t
> (see commit 7fa090844f7d1624c7d1ffc621aae6aec84a1110), let's use
> unsigned int.
> 
> Signed-off-by: Pavel Roskin <proski@gnu.org>
> 
> diff --git a/daemon.c b/daemon.c
> --- a/daemon.c
> +++ b/daemon.c
> @@ -459,7 +459,7 @@ static int serve(int port)
>  
>  			if (FD_ISSET(sockfd, &fds)) {
>  				struct sockaddr_storage ss;
> -				int sslen = sizeof(ss);
> +				unsigned int sslen = sizeof(ss);

Shouldn't this be size_t?

>  				int incoming = accept(sockfd, (struct sockaddr *)&ss, &sslen);
>  				if (incoming < 0) {
>  					switch (errno) {
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
