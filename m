From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] mv: Fix spurious warning when moving a file in presence
 of submodules
Date: Sun, 13 Oct 2013 22:40:48 -0700
Message-ID: <20131014054048.GC25344@google.com>
References: <vpq38o7nao9.fsf@anie.imag.fr>
 <52583B00.8040700@web.de>
 <525A8965.3040407@web.de>
 <vpqr4bp6wkh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 14 07:41:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVau0-0008Ud-MV
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 07:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856Ab3JNFkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 01:40:52 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:54881 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab3JNFkv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 01:40:51 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so6815736pbb.6
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 22:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XO9hQERh3wxhT4L7T4hIz47x/spM1kFRqO0CIp+f9PE=;
        b=x4vcxTlwry7aQk64qu5X07r7xwOC2mtEY88MYF2nx9RBmjVlqJzlXivfk7r3Xe/eKz
         V8xyPgbzmzhJ5dPnW7VcpwPFukZz6m0bsYyFAVymJP4TtFV/QA5ad4sODuWT7SrjluS1
         kg8fdTDS3QsNmWr+ZQGWmfDM63eAeBTebmIc+hNemP/fOM4g0ZwJECsQQl8d3x6q/ISW
         p3rD2PeN1ZVXv6NuQKkl4i9Kwzrs4quS/WJvKAymFV7eED/efyBjyoc29kymZBzYcmBN
         3uT7aDlj6kYvatoP8/09HRPlvywK10t2uoHYribUyxTgcylNrZAij4E4bWQPwkNI7Pm/
         bSKA==
X-Received: by 10.66.146.199 with SMTP id te7mr36237505pab.106.1381729251260;
        Sun, 13 Oct 2013 22:40:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qn1sm75599825pbc.34.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 13 Oct 2013 22:40:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqr4bp6wkh.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236095>

Matthieu Moy wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:

>>  static struct lock_file lock_file;
>> +#define SUBMODULE_WITH_GITDIR ((const char *)1)
>
> I don't like very much hardcoded addresses like this. Are you 100% sure
> address 1 will never be returned by xstrdup on any platform? The risk is
> small if not negligible, but I'm unconfortable with this.

I haven't checked what the standards say, but in practice I think it's
okay.  An alternative would be to do something like

	static const char SUBMODULE_WITH_GITDIR[] = "*** (submodule with gitdir) ***";

which is a bit more error-prone because attempts to use it as a string
wouldn't crash.  We use (void *) 1 in the same way a few places currently.

Thanks, both.
