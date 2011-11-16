From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/3] avoiding unintended consequences of git_path() usage
Date: Wed, 16 Nov 2011 14:44:51 +0100
Message-ID: <4EC3BE53.3020705@alum.mit.edu>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com> <1320510586-3940-4-git-send-email-artagnon@gmail.com> <20111106002645.GE27272@elie.hsd1.il.comcast.net> <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com> <7v7h33oifq.fsf@alter.siamese.dyndns.org> <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com> <20111115095225.GB23139@elie.hsd1.il.comcast.net> <7v7h31wduv.fsf@alter.siamese.dyndns.org> <CALkWK0kOrGzjcGNcf2qPahJSgkvCsQwSrEfAA3wj6PqnMzDBVQ@mail.gmail.com> <20111116075955.GB13706@elie.hsd1.il.comcast.net> <CACsJy8A2=qBiyY3SD-PZo+E=U+Dfjm1UQidgq6khQARZ3d41WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 14:45:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQfnR-000677-56
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 14:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757407Ab1KPNo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 08:44:56 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:52248 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757388Ab1KPNoz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 08:44:55 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAGDiprH010313
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Nov 2011 14:44:52 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <CACsJy8A2=qBiyY3SD-PZo+E=U+Dfjm1UQidgq6khQARZ3d41WQ@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185547>

On 11/16/2011 02:33 PM, Nguyen Thai Ngoc Duy wrote:
> 2011/11/16 Jonathan Nieder <jrnieder@gmail.com>:
>> Jokes aside, here's a rough series to do the git_path ->
>> git_path_unsafe renaming.  While writing it, I noticed a couple of
>> bugs, hence the two patches before the last one.  Patch 2 is the more
>> interesting one.
> 
> Another approach is do nothing and leave it for a static analysis tool
> to detect potential problems. I'm looking at sparse at the moment,
> although I know nothing about it to say if it can or cannot detect
> such problems. We can at least make sparse detect return value from
> git_path() being passed to an unsafe function, I think.

For the cases when static analysis doesn't suffice, recently I posted
some patches that make it possible for debug a problem that results from
the use of a "stale" buffer [1].  But having myself also been bitten by
this problem, I'd also be in favor of a more systematic solution, even
if it has a small runtime cost.  After all, most of the time the
filename created by git_path() is going to be passed to the kernel a
moment later, which will usually be vastly slower than an extra malloc/free.

Michael

[1] http://comments.gmane.org/gmane.comp.version-control.git/182209

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
