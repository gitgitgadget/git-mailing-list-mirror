From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 04/19] index-helper: new daemon for caching index and
 related stuff
Date: Wed, 09 Mar 2016 19:18:25 -0500
Organization: Twitter
Message-ID: <1457569105.13557.19.camel@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	 <1457548582-28302-5-git-send-email-dturner@twopensource.com>
	 <xmqqtwkffdus.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 01:18:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adoJJ-0006Og-7o
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 01:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbcCJAS2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 19:18:28 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35347 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbcCJAS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 19:18:27 -0500
Received: by mail-qg0-f54.google.com with SMTP id y89so57176242qge.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 16:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=m+TJNfiPASak9C8dvlJuToMraHZXiHy0E5ARNRWUxYA=;
        b=rf1FLadtuDK5BfutF/whtcpX5K9QOY833JeR4UBzk9qKAk2XgdyDj1vbNJfec4NLL8
         kYp+FNhBCe0rEDq7DdYl5iV7/5OjVlAjRh2E7FIMESiU87mfGkuFMDfDz/nEkgMWLyhJ
         jWAys4HEmyoIH/od66u/naAmOpO10FnoxPMStp7fIQcBLX2KLY7xumQcTw9MLJ7w3TTC
         LOWbLYX5KvJaSqlnEDhMAcDuMPQoqBdIAn213YL00mfNMpdPDnpUzWFE4loO/FC4q1py
         VPpCjXSbl58cbESu1wl+NZDElDzcmOuyO05AYv+B+AcZkbidfNWUj7iIpSVH2G+IhOJR
         ieoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=m+TJNfiPASak9C8dvlJuToMraHZXiHy0E5ARNRWUxYA=;
        b=QzQP4DbkDvehQl2mO97EoDfDzRsgziZp6itQV7F5EbAp3ZIYmmq8onlS8+7SmTYAF2
         hR2/qv33vLhffEkNt79dcY0+EZZ1Qff5o0oxIZK26dMcSFYdMaWwTmcpMiSZ4n1sK+Il
         fq2zxm0lIbchoKUXTfJ5S8Fkj9B3/W4t+xHdskGcKcDHqOsOP8pYVwKSuWPfbuV6Ax3B
         cQUzc3zQBQg/PpJVC9Yt+slJg43nRyF2e81ofwtcHevc87CXe6w93NTFm/JNBetEmhbn
         v6l7yPjeGWM+NFJ/GVQvWjeEXKbid60PukAABhJKOnPJS46oOQ/9p+xww3P5s2IA+oNH
         dZww==
X-Gm-Message-State: AD7BkJJnkr7sOyuDsnpi/PZlZBq69u5vyISXyz/KAl0M925N4Gb6i4VIKIinXUpXWXmfsQ==
X-Received: by 10.140.220.207 with SMTP id q198mr637531qhb.103.1457569106521;
        Wed, 09 Mar 2016 16:18:26 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id c18sm539838qgd.49.2016.03.09.16.18.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 16:18:25 -0800 (PST)
In-Reply-To: <xmqqtwkffdus.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288588>

On Wed, 2016-03-09 at 15:09 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
>=20
> > From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> >=20
> > Instead of reading the index from disk and worrying about disk
> > corruption, the index is cached in memory (memory bit-flips happen
> > too, but hopefully less often). The result is faster read. Read
> > time
> > is reduced by 70%.
> >=20
> > The biggest gain is not having to verify the trailing SHA-1, which
> > takes lots of time especially on large index files. But this also
> > opens doors for further optimiztions:
> >=20
> >  - we could create an in-memory format that's essentially the
> > memory
> >    dump of the index to eliminate most of parsing/allocation
> >    overhead. The mmap'd memory can be used straight away.
> > Experiment
> >    [1] shows we could reduce read time by 88%.
> >=20
> >  - we could cache non-index info such as name hash
> >=20
> > The shared memory's name folows the template "git-<object>-<SHA1>"
> > where <SHA1> is the trailing SHA-1 of the index file. <object> is
> > "index" for cached index files (and may be "name-hash" for name
> > -hash
> > cache). If such shared memory exists, it contains the same index
> > content as on disk. The content is already validated by the daemon
> > and
> > git won't validate it again (except comparing the trailing SHA-1s).
>=20
> This indeed is an interesting approach; what is not explained but
> must be is when the on-disk index is updated to reflect the reality
> (if I am reading the explanation and the code right, while the
> daemon is running, its in-core cache becomes the source of truth by
> forcing everybody's read-index-from() to go to the daemon).  The
> explanation could be "this is only for read side, and updating the
> index happens via the traditional 'write a new file and rename it to
> the final place' codepath, at which time the daemon must be told to
> re-read it."

This seems like the explanation (from the current commit message):

"Git can poke the daemon to tell it to refresh the index cache, or to
keep it alive some more minutes via UNIX signals. It can't give any
real index data directly to the daemon. Real data goes to disk first,
then the daemon reads and verifies it from there. Poking only happens
for $GIT_DIR/index, not temporary index files."

I guess this could be rewritten as:

"Index validity is ensured by the following method: When a read is
requested from the index-helper, it checks the SHA1 of its cached index
copy against the on-disk version.  If they differ, index-helper rereads
the index.  In addition, any git process may explicitly suggest a
reread via a UNIX signal, but this is only an optimization and it is
not necessary for correctness.

In addition, Git can signal the daemon with a heartbeat signal, to keep
the daemon alive longer."

How does that sound?
