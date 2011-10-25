From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] mingw: implement PTHREAD_MUTEX_INITIALIZER
Date: Tue, 25 Oct 2011 17:28:20 +0200
Message-ID: <4EA6D594.90402@viscovery.net>
References: <1319554509-6532-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 17:28:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIivY-00067j-RO
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 17:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649Ab1JYP21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 11:28:27 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:12022 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752130Ab1JYP21 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 11:28:27 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RIivP-0002Zq-Jt; Tue, 25 Oct 2011 17:28:23 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4430E1660F;
	Tue, 25 Oct 2011 17:28:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <1319554509-6532-1-git-send-email-kusmabite@gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184210>

Am 10/25/2011 16:55, schrieb Erik Faye-Lund:
> +int pthread_mutex_lock(pthread_mutex_t *mutex)
> +{
> +	if (mutex->autoinit) {
> +		if (InterlockedCompareExchange(&mutex->autoinit, -1, 1) != -1) {
> +			pthread_mutex_init(mutex, NULL);
> +			mutex->autoinit = 0;
> +		} else
> +			while (mutex->autoinit != 0)
> +				; /* wait for other thread */
> +	}

The double-checked locking idiom. Very suspicious. Can you explain why it
works in this case? Why are no Interlocked functions needed for the other
accesses of autoinit? ("It is volatile" is the wrong answer to this last
question, BTW.)

-- Hannes
