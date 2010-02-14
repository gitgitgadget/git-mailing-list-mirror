From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: mmap with MAP_PRIVATE is useless
Date: Sun, 14 Feb 2010 03:11:30 +0100
Message-ID: <4B775BD2.3040007@gnu.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> <20100212002741.GB9883@progeny.tock> <4B775384.50009@gnu.org> <7vy6iw4m6r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Zygo Blaxell <zblaxell@gibbs.hungrycats.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 03:11:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgTxn-0000KG-Gx
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 03:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758272Ab0BNCLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 21:11:35 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:63814 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758118Ab0BNCLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 21:11:34 -0500
Received: by fxm27 with SMTP id 27so145719fxm.25
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 18:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=sdEJpqO0DtFVeohRgJoHz7XYWaKO4RmDCW1YLW2fcYY=;
        b=JYWzbi4/h6np/G+OY0DY7qdqcqAT5FGAbPvvI/sX0n0IwWr9qwuCIMcmGXU0kRVhiA
         E3MEt5a5lcs5Dv6SVENgb0FqdxMbddlFVdMZCPkyQ0Jy1AxIDJGxsEpuAPsffbYj2ekR
         hcaQESXviY60AHIQb59oV0jKCCxFUSuQjbV2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=aReoN7My0P/b0WMYNni7DC/M1Q2IjrNe/W5SXz6gS2ocgM1jLtHCFAY3Al7ONJD5BC
         nvi8H+V6ruMqYRltDWeQchHjTwU7GnYfaKJC2g/phrW9dusyfbbpopYFrVWUOCL89gpx
         W7IMS0UB5gsKekO7p6ke9oIPfNA1+GHefMBQw=
Received: by 10.223.97.220 with SMTP id m28mr3852849fan.36.1266113492271;
        Sat, 13 Feb 2010 18:11:32 -0800 (PST)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 18sm7979494fks.4.2010.02.13.18.11.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Feb 2010 18:11:31 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <7vy6iw4m6r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139882>

On 02/14/2010 02:53 AM, Junio C Hamano wrote:
> Back when most of these mmap calls were written by Linus and myself,
> we weren't interested in using MAP_PRIVATE, or any other trick for
> that matter, to deal with the case where the user tells git to go
> index a file, and then mucks with the file before git finishes and
> gives back control.

Eh, this one in particular (in index_fd) is quite ancient...

commit e83c5163316f89bfbde7d9ab23ca2e25604af290
Author: Linus Torvalds <torvalds@ppc970.osdl.org>
Date:   Thu Apr 7 15:13:13 2005 -0700

     Initial revision of "git", the information manager from hell

:-)

There were three mmap calls -- in read_sha1_file, read_cache and 
index_fd -- and all three were of the same mmap (NULL, st.st_size, 
PROT_READ, MAP_PRIVATE, fd, 0) shape.

Paolo
