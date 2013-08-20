From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] stream_to_pack: xread does not guarantee to read all
 requested bytes
Date: Tue, 20 Aug 2013 20:27:59 +0200
Message-ID: <5213B52F.7030205@kdbg.org>
References: <521333AE.1090506@kdbg.org> <xmqqsiy476h4.fsf@gitster.dls.corp.google.com> <CALWbr2yaQaCte6+Y3GEa8Hxyhq6GPS64aTNzkGo8pdpcd9ZVUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 20:28:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBqfE-0000N8-3K
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 20:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725Ab3HTS2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 14:28:08 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:64360 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751378Ab3HTS2F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 14:28:05 -0400
Received: from [10.73.122.231] (178.115.250.231.wireless.dyn.drei.com [178.115.250.231])
	by bsmtp.bon.at (Postfix) with ESMTP id D9B4310017;
	Tue, 20 Aug 2013 20:28:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CALWbr2yaQaCte6+Y3GEa8Hxyhq6GPS64aTNzkGo8pdpcd9ZVUg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232625>

Am 20.08.2013 17:16, schrieb Antoine Pelisse:
> I was actually wondering when it's better to use xread() over
> read_in_full() ? Considering that we don't know if xread() will read
> the whole buffer or not, would it not be better to always use
> read_in_full() ?

Of course, you know whether the whole buffer was filled: xread() returns 
the number of bytes read. Same for xwrite().

> I guess there is a drawback to this, but I'm not
> exactly sure what it is.

The disadvantage of read_in_full() is that it can happen that it reads 
data from the stream successfully, but then reports an error. In this 
case, the data read is lost.

Analogously, when write_in_full() writes (some) data successfully, but 
ultimately fails, you don't know how much was written successfully.

-- Hannes
