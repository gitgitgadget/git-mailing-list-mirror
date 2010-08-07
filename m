From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] pack-object: trim memory usage a tiny bit
Date: Sat, 7 Aug 2010 10:16:43 +1000
Message-ID: <AANLkTimEFjRuuO+GnAV7PGe0oPi-Qh37iLS6o3Q8Undw@mail.gmail.com>
References: <1281114057-5982-1-git-send-email-pclouds@gmail.com>
	<AANLkTikphara-0NXaBZ-MAygytGYDuN6ANcMWE+Ni3mW@mail.gmail.com>
	<AANLkTikL8MtqFr1T=3TKA7GLKSEbyvf+6SLTT2BYehto@mail.gmail.com>
	<AANLkTingdhx5osnbiLVMyWaauCf1TRiMzcSC76gQRp9B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 02:16:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhX5o-0002wj-VF
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 02:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762232Ab0HGAQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 20:16:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36864 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762204Ab0HGAQo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 20:16:44 -0400
Received: by wyb39 with SMTP id 39so8317249wyb.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 17:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=tvLIzisHfs9dEqM54+R4GzqvPx7YnGDdQI8iKe73Bwg=;
        b=pKRqRknL7YnomrDJteAacp15RIf4KIx887tBuPUAW+3gby4fg7ajp1U7du5NfV6tLi
         yk6owreC1N6yDRs0mOH8VD99B/IJdL/mNMNFVo+pRrmUQ2fN0+XJRi4lFkny6bn9E0hF
         InC3uthlrXegl9j+LsARDk6IhNG3Q2GafJAL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wAOnTeRxyfWc/z+F/gZvH7R0lpc+GX0q11n8ADE1S6sKKhGu8BDU1UYauF2Jy25M5g
         ujAKCE4SmEHIk59bkfmJg3E8zpjzjmUBnFLDRoKDQpcnwj+ec3eXkHyrZM+tpLGHIWmX
         2ZU6DmPnIRfca0SDhi/dvGU9vruijmSmf/bVc=
Received: by 10.216.196.160 with SMTP id r32mr11299449wen.36.1281140203538; 
	Fri, 06 Aug 2010 17:16:43 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Fri, 6 Aug 2010 17:16:43 -0700 (PDT)
In-Reply-To: <AANLkTingdhx5osnbiLVMyWaauCf1TRiMzcSC76gQRp9B@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152829>

On Sat, Aug 7, 2010 at 10:04 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Fri, Aug 6, 2010 at 19:03, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> struct object_entry is allocated for every object to be packed. So if
>> you do a clone on linux-2.6, you would need 1.6M of those structs, 88
>> bytes each. I cut 8 bytes from each of them.
>
> Sure, that was clear enough. But _how_? What needs to be done to
> retain this? Are there any downsides?

Ah, by packing it tighter using bitfields. There are two fields that
act as boolean, but they use at least one byte each. And enum
object_type, I recall, uses 4 bytes (int), while it only needs 5 bits
(4 bits is enough if OBJ_BAD is not counted). No downsides I know of.
-- 
Duy
