From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] index-pack: fix truncation of off_t in comparison
Date: Thu, 4 Jun 2015 20:10:03 +0700
Message-ID: <CACsJy8BUEcduXf3LCbwGnJRYNb4s1KEKj_hwdo0qCtJoS4SgFw@mail.gmail.com>
References: <20150604123541.GA8888@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 15:11:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Uuu-0000Xt-FC
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 15:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594AbbFDNKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 09:10:36 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:32923 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbbFDNKe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 09:10:34 -0400
Received: by iebgx4 with SMTP id gx4so35527126ieb.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EKlOYOuDUx19m4wV0QxpWskQSlDui8grSBF02wRYavc=;
        b=c4AR0hQn5eqdQXHcATCbExdXCA+UsTHunmLchp0Fzz4MK/RDNETwaFHk6B1yQBi+Ck
         ttMmp8IJBXuz2RrW/NEQDvYR+KEdMOalmX25kwMUt+G91WBnLAyMBY7l0d9fpWdRnlfY
         DoFjdGHdpNz4RjfdYjD+Fec7IcIIxUDUQKeswp8/CecEF+a5ZLnm31w/WFcHhVX1S+iy
         QQAfzgZ1GWkfqpOB00ZOkgtLihX4EeYwrU5hjZHfHPdf+Eh9aqyGw0Dl1sjiDUzr6/O7
         57PauYe6PUYqIeBaOp4meXvQrnm/kLB8MCqPTVqo30Jk6ueS46v8eYxOuzOd+8NXMHHu
         rIMQ==
X-Received: by 10.107.47.224 with SMTP id v93mr19065047iov.86.1433423433446;
 Thu, 04 Jun 2015 06:10:33 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Thu, 4 Jun 2015 06:10:03 -0700 (PDT)
In-Reply-To: <20150604123541.GA8888@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270773>

On Thu, Jun 4, 2015 at 7:35 PM, Jeff King <peff@peff.net> wrote:
> Commit c6458e6 (index-pack: kill union delta_base to save
> memory, 2015-04-18) refactored the comparison functions used
> in sorting and binary searching our delta list. The
> resulting code does something like:
>
>   int cmp_offsets(off_t a, off_t b)
>   {
>           return a - b;
>   }
>
> This works most of the time, but produces nonsensical
> results when the difference between the two offsets is
> larger than what can be stored in an "int".

Ugh.. thanks for fixing this. Too bad neither gcc, clang or coverity
spotted this.
-- 
Duy
