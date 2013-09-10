From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 15/16] index-pack: use nr_objects_final as sha1_table size
Date: Tue, 10 Sep 2013 07:45:45 +0700
Message-ID: <CACsJy8D=72RsnNKs-6EdUnhu6kurvQ5S2z5PkV3KcY7SUDHJKg@mail.gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com> <1378735087-4813-16-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309091047510.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 10 02:46:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJC61-00029W-16
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 02:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093Ab3IJAqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 20:46:16 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:60691 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab3IJAqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 20:46:15 -0400
Received: by mail-oa0-f41.google.com with SMTP id j6so7278464oag.14
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 17:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NIr955EkP0TPjOwkgkkwecYQ5i3fK94Df5M57IGtrLE=;
        b=yzekKDb4Ci27Yl1Ig9SjK51TV24+hblVaGlGtvHK08ka4Dc4a1SMw8xHRtqjWIV783
         mn+v6B2NiaTGvNZgRvJ9s0knJ9DX/kcKYMhJZkxJX1vwIQoNvycyt1kRN6umeZYXFal5
         EwgcPZRTwr4TJgY3zxuwNE1hYUFVOQtMFnI3+dV3Jf+LhPcgPlAOmWivSPDRsdA+mnYW
         tItV1vtXjCIzNwP35WrZ9cyekx3YBnitLtl43t4kksRyA7RzJQbo2uPhKMD0xlmeMb3g
         PcyH94GeT8Ike7LiHNqSqaz51+Ikc4QdwhZQKiT9QCoIToxzBrgTIh0unB3/kvBSTGCi
         Kmzg==
X-Received: by 10.60.51.41 with SMTP id h9mr2966754oeo.49.1378773975095; Mon,
 09 Sep 2013 17:46:15 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Mon, 9 Sep 2013 17:45:45 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309091047510.20709@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234404>

On Mon, Sep 9, 2013 at 10:01 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> However this means that the progress meter will now be wrong and that's
> terrible !  Users *will* complain that the meter doesn't reach 100% and
> they'll protest for being denied the remaining objects during the
> transfer !
>
> Joking aside, we should think about doing something about it.  I was
> wondering if some kind of prefix to the pack stream could be inserted
> onto the wire when sending a pack v4.  Something like:
>
> 'T', 'H', 'I', 'N', <actual_number_of_sent_objects_in_network_order>
>
> This 8-byte prefix would simply be discarded by index-pack after being
> parsed.
>
> What do you think?

I have no problem with this. Although I rather we generalize the case
to support multiple packs in the same stream (in some case the server
can just stream away one big existing pack, followed by a smaller pack
of recent updates), where "thin" is just a special pack that is not
saved on disk. So except for the signature difference, it should at
least follow the pack header (sig, version, nr_objects)
-- 
Duy
