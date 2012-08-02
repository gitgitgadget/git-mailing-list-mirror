From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/16] Modify match_stat_basic to prepare for other index formats
Date: Thu, 2 Aug 2012 19:20:40 +0700
Message-ID: <CACsJy8Cr4DoO5aw4-CJPN8j1CiWw+pU+5=_cB+mmViUvMU6BOw@mail.gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com> <1343905326-23790-4-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 14:21:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwuPA-00021g-CQ
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 14:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab2HBMVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 08:21:16 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34474 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449Ab2HBMVN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 08:21:13 -0400
Received: by yenl2 with SMTP id l2so8611754yen.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FbBR030HBuvzsMv9XPOQ0lby/7qgCi7UE2uEpzvTdZk=;
        b=WePMdWjX9P7yTxaFVeymexj1LJpxEWI421PlHMDQSmoTmxYSSK5grDNfGCNDKbKQeg
         5PmJYCOH7Jcxe9yKxTlVadfQ2Uc4euV53CU9W0UOAc9FQc0Ys+ihBnCg1V+6K7j/FcWb
         AlrB197lwIrPNe9e52GFP19c1c5+hjLi/S2hdpBldVIyB0wst7C7JWu6DKeiKQmd31Nz
         FefJd8r1+zmNawYzKFltibCqeV9iXspnuNf040yoq3X3HLb+5nT1AI2AuEA6dI7b2VN7
         nA0iR8lx9OTSAMyRE6axEaPzUiiGe2OTYc2Azk39iGllSoQ8Hlve2AQjclkLtFH+Dtuz
         Lc6Q==
Received: by 10.50.87.131 with SMTP id ay3mr3368323igb.36.1343910072240; Thu,
 02 Aug 2012 05:21:12 -0700 (PDT)
Received: by 10.64.90.2 with HTTP; Thu, 2 Aug 2012 05:20:40 -0700 (PDT)
In-Reply-To: <1343905326-23790-4-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202771>

On Thu, Aug 2, 2012 at 6:01 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> @@ -1443,7 +1452,6 @@ void read_index_v2(struct index_state *istate, void *mmap, int mmap_size)
>                 src_offset += consumed;
>         }
>         strbuf_release(&previous_name_buf);
> -
>         while (src_offset <= mmap_size - 20 - 8) {
>                 /* After an array of active_nr index entries,
>                  * there can be arbitrary number of extended
> @@ -1500,7 +1508,6 @@ int read_index_from(struct index_state *istate, const char *path)
>                 die("index file smaller than expected");
>
>         mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> -       close(fd);
>         if (mmap == MAP_FAILED)
>                 die_errno("unable to map index file");
>
> @@ -1512,7 +1519,6 @@ int read_index_from(struct index_state *istate, const char *path)
>                 goto unmap;
>
>         read_index_v2(istate, mmap, mmap_size);
> -
>         istate->timestamp.sec = st.st_mtime;
>         istate->timestamp.nsec = ST_MTIME_NSEC(st);
>

you could have done this in 02/16 when you introduced this block.

> @@ -1802,9 +1808,6 @@ int write_index(struct index_state *istate, int newfd)
>                 }
>         }
>
> -       if (!istate->version)
> -               istate->version = INDEX_FORMAT_DEFAULT;
> -
>         /* demote version 3 to version 2 when the latter suffices */
>         if (istate->version == 3 || istate->version == 2)
>                 istate->version = extended ? 3 : 2;

why? it does not seem to be related to the commit message.
-- 
Duy
