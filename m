From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] fetch-pack: save shallow file before fetching the pack
Date: Fri, 5 Apr 2013 13:11:14 +1100
Message-ID: <CACsJy8CEEoL7LxDNzD=dwp_8qxeHgDr+fuswXrRcD32k9zfT5w@mail.gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
 <1364728148-7537-2-git-send-email-pclouds@gmail.com> <7v6206l2t6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 04:12:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNw8U-0006T7-Bv
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 04:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161281Ab3DECLq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Apr 2013 22:11:46 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:40254 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161001Ab3DECLp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Apr 2013 22:11:45 -0400
Received: by mail-ob0-f177.google.com with SMTP id uz6so3297642obc.36
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 19:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=ss7I3kDFJDrJRgaM8yYFg+HiPMjIBuFIky/A3EGcUaE=;
        b=ebX+g06zBDm3Nuus9JPQnUKHx6kE1ajvQiM6uRVgVX7ljr10UpnQA9Bj7QKIIdI8tW
         v3ql8Ml3o6eW1k2pgKwUujsPOvM6JuE4/YRLhEgiMhzae9Vo1xXFVhDZUdphqdBioMp4
         TgCO5iAGcTUDMqrr0YcUAdwP4ynFE/ktU1jlq1xlevfRNd3KeqdRflQY7KrFSxW1TbRI
         UboH8kqrkxvHin9GsESIjVURwSOlq7lEKw+NPeU73p1DVfITPVrdReQw0YqAuyXGSytW
         3I/DCjVTEuyPJGAe/dzG1AtLa5NcaAqbH29KxUBm8V1OYaByncA5CGAIqVrDogGQbd9j
         nwew==
X-Received: by 10.60.96.10 with SMTP id do10mr490942oeb.123.1365127904851;
 Thu, 04 Apr 2013 19:11:44 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Thu, 4 Apr 2013 19:11:14 -0700 (PDT)
In-Reply-To: <7v6206l2t6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220131>

On Tue, Apr 2, 2013 at 1:53 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> index-pack --strict looks up and follows parent commits. If shallow
>> information is not ready by the time index-pack is run, index-pack m=
ay
>> be lead to non-existent objects. Make fetch-pack save shallow file t=
o
>> disk before invoking index-pack.
>
> I think the problem the patch is trying to solve _is_ real, but I
> wonder if this is a correct approach to solve it.  What happens if
> we die in the middle after writing the updated shallow file
> prematurely?
>
> Perhaps the index-pack (or any "Git" process in general) needs to
> learn a way to use an alternate shallow file, instead of always
> using a hard-coded git_path("shallow"), so that you can flush an
> updated one to a to-be-the-next-shallow-file, run fetch-pack with
> that alternate shallow file, and rename it to the final name at the
> end after everything goes well, or something?

Yeah. I was focused on the clone case so it didn't matter but this
change applies to git-fetch as well. Will add new GIT_SHALLOW_FILE
environment variable.
--
Duy
