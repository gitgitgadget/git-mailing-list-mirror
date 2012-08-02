From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 03/16] Modify match_stat_basic to prepare for other index
 formats
Date: Thu, 2 Aug 2012 16:16:26 +0200
Message-ID: <20120802141626.GE1000@tgummerer.unibz.it>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
 <1343905326-23790-4-git-send-email-t.gummerer@gmail.com>
 <CACsJy8Cr4DoO5aw4-CJPN8j1CiWw+pU+5=_cB+mmViUvMU6BOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 16:16:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwwCj-000219-Ex
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 16:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283Ab2HBOQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 10:16:31 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52184 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab2HBOQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 10:16:29 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so4273873bkw.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=i/GVxCCtKI+n1JdTbVfJtU++ZJRxee0y8OMrHADRZ3c=;
        b=dQFwJCNH7AWLpEkV62AA7ioDgZvk6V7+LaVLl5jauOdrx4TTbH+QUazE9N8AJIaYbf
         fFXocP9CpLL39UwcTWeC6iEbEbCgALNEMdRmThFg0D+OXPVpmspSuwi1TwGTg6xYfY4m
         ftWLZxXBkPq4XflHzDr0nS/t38aWjhgfCCsQevCCOiWAMJG3aB7b8hQEVflO4v8/Hvdy
         eEGMqUow172WmwZpK7Nh6LJ+zs9bCpIpc5q7W9LRP18av1upFuLS0guxUnsnmNOvlu4I
         I44AXJNxNZpQKrLQ4DsLy08/by5YEzCMnn9cZgRN/IuTEhAvDpsfv3hak3Qu3pb0Jmv6
         Apwg==
Received: by 10.204.157.135 with SMTP id b7mr8306329bkx.61.1343916988519;
        Thu, 02 Aug 2012 07:16:28 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id ht18sm3505342bkc.16.2012.08.02.07.16.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 07:16:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8Cr4DoO5aw4-CJPN8j1CiWw+pU+5=_cB+mmViUvMU6BOw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202780>

On 08/02, Nguyen Thai Ngoc Duy wrote:
> On Thu, Aug 2, 2012 at 6:01 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > @@ -1443,7 +1452,6 @@ void read_index_v2(struct index_state *istate, void *mmap, int mmap_size)
> >                 src_offset += consumed;
> >         }
> >         strbuf_release(&previous_name_buf);
> > -
> >         while (src_offset <= mmap_size - 20 - 8) {
> >                 /* After an array of active_nr index entries,
> >                  * there can be arbitrary number of extended
> > @@ -1500,7 +1508,6 @@ int read_index_from(struct index_state *istate, const char *path)
> >                 die("index file smaller than expected");
> >
> >         mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> > -       close(fd);
> >         if (mmap == MAP_FAILED)
> >                 die_errno("unable to map index file");
> >
> > @@ -1512,7 +1519,6 @@ int read_index_from(struct index_state *istate, const char *path)
> >                 goto unmap;
> >
> >         read_index_v2(istate, mmap, mmap_size);
> > -
> >         istate->timestamp.sec = st.st_mtime;
> >         istate->timestamp.nsec = ST_MTIME_NSEC(st);
> >
> 
> you could have done this in 02/16 when you introduced this block.

Thanks.

> > @@ -1802,9 +1808,6 @@ int write_index(struct index_state *istate, int newfd)
> >                 }
> >         }
> >
> > -       if (!istate->version)
> > -               istate->version = INDEX_FORMAT_DEFAULT;
> > -
> >         /* demote version 3 to version 2 when the latter suffices */
> >         if (istate->version == 3 || istate->version == 2)
> >                 istate->version = extended ? 3 : 2;
> 
> why? it does not seem to be related to the commit message.

Sorry this is wrong, it should belong to patch 4. Thanks for noticing.
