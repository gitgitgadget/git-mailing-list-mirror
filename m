From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v3 0/4] git-p4: Improve branch support
Date: Fri, 19 Aug 2011 15:30:01 +0100
Message-ID: <CAOpHH-WeLWyEZaktYRzVN+dfgqu3==o4bgrfzpvS-QUCQboPgg@mail.gmail.com>
References: <1313711046-23489-1-git-send-email-vitor.hda@gmail.com> <20110819115310.GC15639@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 16:31:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuQ6N-0004Px-Ft
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 16:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871Ab1HSObC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 10:31:02 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40988 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab1HSOac convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 10:30:32 -0400
Received: by ywf7 with SMTP id 7so2220098ywf.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8wxM5z75OfD0XXiG7mbI64vQDChU/EKNSBpkvyb39/o=;
        b=OORMfvZKdQVhF75mgN8YalMqBEJuKuLjqXpAEMim1inV4ha6LM5FXMOE7MeGIEvrZx
         DrCl7nRwjEgurffFOItN7tSFyGXPokCFGWJyZL72m/TkmYhK6CgaeuFYCn3IH42n20Cd
         9nyzchJ/yEA8+2FDjeSLJtP9nALFaYgMNU3Bs=
Received: by 10.236.116.233 with SMTP id g69mr8026233yhh.39.1313764232347;
 Fri, 19 Aug 2011 07:30:32 -0700 (PDT)
Received: by 10.231.19.8 with HTTP; Fri, 19 Aug 2011 07:30:01 -0700 (PDT)
In-Reply-To: <20110819115310.GC15639@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179702>

On Fri, Aug 19, 2011 at 12:53 PM, Pete Wyckoff <pw@padd.com> wrote:
> Patches 1 and 2 are great. =A0We should have gotten those in way
> back when you first submitted them. =A0I happily ack those.
>
> I'm still a bit hung up on #3, mainly because I don't get branch
> support. =A0Let me play around with your test. =A0Having this
> playbook of how it is supposed to work will help to educate me.

(I am probably going in too much detail here. Please skip any
redundant information.)

In general, you can see branches in P4 as you do in SVN. They are
simple copies from one directory to another. For example:

    p4 integrate //depot/big/directory/path/myproj/version_A \
                 //depot/big/directory/path/myproj/version_B

Now the history of "version_B" is tied to "version_A". If you want to
integrate (merge, in this case) new updates from one of the
directories to the other you can just rerun the above command
(version_A and version_B order may change depending on the direction
of the merge).

P4 also allows you to define "branch specs" that you can use as a
short hand instead of having to type in the full directory paths. So,
assuming that you have a branch named "myproj_B" with the following
view defined:

    //depot/big/directory/path/myproj/version_A \
        //depot/big/directory/path/myproj/version_B

When you want to integrate it again you can simply type:

    p4 integrate -b myproj_B

or, if you want to integrate from version_B into version_A instead:

    p4 integrate -b myproj_B -r

git-p4 is using these branch specs to identify branches. Without this
extra information it is nearly impossible for it to identify branches
because an integrate can be done of a single file.

But since P4 does not strictly require branch specs and because most
of the time integrations are done through P4V, then most of the time
no branch specs are created. Now, if this happens git-p4 will not be
able to detect branches! And creating branches in P4 just for git-p4
does not make much sense, right? This is the main reason behind the
third patch... :)

Sorry for the long email.

--=20
Vitor Antunes
