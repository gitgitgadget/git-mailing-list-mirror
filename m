From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 18/24] read-cache: write index-v5
Date: Sat, 24 Aug 2013 16:56:51 +0700
Message-ID: <CACsJy8A_Gn1996BFF4D-apc+PsfXL5EO+tKetuqZ0cFfUnqb+w@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
 <1376854933-31241-19-git-send-email-t.gummerer@gmail.com> <CACsJy8C8rpz2zNvKB_MEbUShKGMfknDO10C47y3YDV-0-hFKLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 24 11:57:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDAb2-0008LG-11
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 11:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357Ab3HXJ5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 05:57:23 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34467 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754971Ab3HXJ5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 05:57:22 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so1626385obb.19
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 02:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oPdF6FsgRfwOHD/WROcAS77jPcxiqdUhicNxVPIlQ2o=;
        b=K2gqNLdXQdmeeeMAMPJAHVAi668JWZ5HDw+2f7mhT0fksS5IAv8jR3u7/fr8NuY8cy
         I0POF6y6b//9QGvHvI9H9rwUXcrn8OvaKTh0tZSEb5d/U0tYwuz18nonN6Mc1sTk1yeG
         ek+bZUys8blD/K7U+9WDE0kXvRcobF72cnjVE1nU886xlgHk/fTfX7uhma/OqF/XoOwF
         cfV+JaRLd6OD+WrUy5yGQulwzLIMme9FNEQLV/vzhQJGrUVXVjy+8/TVQZm3Suz8ISQH
         ziSZzmYJcC+Fv90vDSvE1Ycu7UhKzHzSusuEkGbH/eXePb2lfa20MMOqDZy4WbztL/pt
         fWsg==
X-Received: by 10.60.115.164 with SMTP id jp4mr3878179oeb.19.1377338242143;
 Sat, 24 Aug 2013 02:57:22 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Sat, 24 Aug 2013 02:56:51 -0700 (PDT)
In-Reply-To: <CACsJy8C8rpz2zNvKB_MEbUShKGMfknDO10C47y3YDV-0-hFKLg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232883>

On Sat, Aug 24, 2013 at 11:07 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Aug 19, 2013 at 2:42 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> Write the index version 5 file format to disk. This version doesn't
>> write the cache-tree data and resolve-undo data to the file.
>
> I keep having things to add after sending my emails. Now that we have
> all conflicted entries in file block, the conflict data block becomes
> optional, it functions exactly (I think) like resolve-undo extension,
> which makes me think it might make sense to make conflict data block
> an extension.
>
> If we make it so, we might want to move "cr" and "ncr" fields out of
> direntries. I don't see a solution yet, but I think it's interesting
> because future extensions might want to attach stuff to direntries,
> just like "cr"/"ncr" from conflict extension. We may want to think now
> how that might be done (and conflict extension is a good exercise to
> see how it works out)

And the solution is pretty obvious: keep resolve-undo extension as
_extension_ just like in v2 (and no "cr/ncr" in direntries). The only
difference is the time resolve-undo extension is updated: in v2, new
entries are added at remove_index_entry_at(), in v5 new entries are
added when new stage entries  are detected at write_index().
-- 
Duy
