From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Sat, 25 Dec 2010 09:20:56 +0700
Message-ID: <AANLkTi=tyEPWMxo2OGbgnCAE938aYzSvaWr7WyZFj3nF@mail.gmail.com>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org> <AANLkTinH0h5euL=_wMpGirVEEYgoA9hXGhKGja9oPa2j@mail.gmail.com>
 <7vfwto2ytb.fsf@alter.siamese.dyndns.org> <4D13DCDD.3050300@workspacewhiz.com>
 <AANLkTikaBfVw-4eD9qeGSdM5xKxq-gJ-3oAe4B2qt4od@mail.gmail.com> <4D14CFF2.9050705@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sat Dec 25 03:21:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWJlG-0007bZ-62
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 03:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451Ab0LYCV2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Dec 2010 21:21:28 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57205 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab0LYCV2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Dec 2010 21:21:28 -0500
Received: by wyb28 with SMTP id 28so7301964wyb.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 18:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jVReauuzqBwKisGf2Y9n5Qd8icePsplQztbtcm2t3Dg=;
        b=jid0N775lFg7Qd6q6fdXu8zD9Uh3saJ5fPVw/3mawG0Y8m96X6s6ejwA46uMW10pMu
         x/WR549RA6YeE9WhwmivsadFBkM2KNZZN1bQCRi7tM8vbR6qgLsgoP655H20m4FWcyxE
         13ujxK0AgCG9wKLvYdTpilia+jdz4m/A1+rf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JQA0+twYOy0naoWEIEZvdifHZogIu9D+2+FAYS42s4snH43jZ1mYWSJKRY0s23Na4l
         y+fsGnHW2UZjI7PMuiqyPReQoZt/bazLRk7WYgoPDvNf3LykrssRzr2EqQl2VNJ4ffi1
         uLwxqdB2CuBrdgW9o3ipmURHi/sX4mJm1UABo=
Received: by 10.216.169.71 with SMTP id m49mr11078291wel.4.1293243687079; Fri,
 24 Dec 2010 18:21:27 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Fri, 24 Dec 2010 18:20:56 -0800 (PST)
In-Reply-To: <4D14CFF2.9050705@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164168>

On Fri, Dec 24, 2010 at 11:53 PM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
> As I recall (I'd have to examine other unsubmitted case insensitivity
> patches), merely adding case insensitivity support to ce_path_match()=
 is not
> enough. =C2=A0The cache is stored alphabetically in a case sensitive =
fashion.
> =C2=A0That means filenames starting with 'A' are stored in a complete=
ly different
> place than filenames starting with 'a'. =C2=A0Certain parts of the co=
de call
> ce_path_match() and then walk the cache sequentially for possible mat=
ches.
> =C2=A0It aborts long before hitting the 'a' filename.

Hmm.. what you describe sounds like never_interesting optimization in
tree_entry_interesting(). By the way do you still remember the parts
that it walk sequentially after ce_path_match() is matched?

> I have a patch that appears to resolve most of these issues. =C2=A0Fo=
r
> core.ignorecase=3Dtrue, when the cache is read, it is re-sorted alpha=
betically
> in a case insensitive manner. =C2=A0ce_path_match() still needs fixes=
, but the
> rest were covered by the case insensitive cache. =C2=A0'A' and 'a' ar=
e not
> interleaved, and the combination of sequential and binary(?) searches=
 Git
> uses are successful. =C2=A0Finally, when the cache is written, I re-s=
ort the
> cache in a case insensitive fashion.

Resorting the cache is quite risky. Many parts of git depend on the
cache being sorted as it is now. Also if you go this way, then you
will also need to resort tree objects (git-log walks them directly).
--=20
Duy
