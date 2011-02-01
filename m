From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Tracking empty directories
Date: Wed, 2 Feb 2011 00:54:35 +0700
Message-ID: <AANLkTi=u6=mhOd9LFYRy48y41xRcXmYDtktOKoBjjMgO@mail.gmail.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com> <20110201172835.GA3771@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 18:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkKRf-0008Mz-J1
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 18:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990Ab1BARzK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 12:55:10 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56384 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980Ab1BARzH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 12:55:07 -0500
Received: by wwa36 with SMTP id 36so7306617wwa.1
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 09:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=RSvpSvo3Qu0ac2pSzqG7hRidjb5NJxkI2wk1/pbOEj8=;
        b=eQauD7G3BBYKffyDbgA8Ys2EzI92O3El/rQAkTilBpRVsR/lsEbjxKan0omIDM7p7Z
         yrE40SRk7fkvbbA9mmmmNDnIgQGnxUwO0UlmsCq+eCSGFgJ3V1Rn2AsU769vSXA0GYx1
         gjnIx63V6fPMEQgS+Td3T7q41KlW9h5KAXDAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VX4r3Pb2v23XEu4cmRzxvmFMDiHodZ8VH/LFVLvabj5FmJ5h/LgSwbujtiVnPOIOmY
         VuhbemgHpfSRisUaGg6MizP/YC4YyqpRAoJc+HL4Fhl6+428STWJIdrziml1XviBH+FF
         mCDgVA2Li5DHx2RzZYetO6MwM9ST6kAgW/rqc=
Received: by 10.216.52.134 with SMTP id e6mr1657576wec.49.1296582905927; Tue,
 01 Feb 2011 09:55:05 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 1 Feb 2011 09:54:35 -0800 (PST)
In-Reply-To: <20110201172835.GA3771@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165836>

On Wed, Feb 2, 2011 at 12:28 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jakub Narebski wrote:
>
>> Also one needs to remember that this would require adding extension
>> to git index, because currently it tracks only files, and not
>> directories. =C2=A0Explicitly tracking directories in the index coul=
d be
>> useful for other purposes...
>>
>> The major difficulty of this is IMHO not the UI, but tracking all th=
ose
>> tricky corner cases (like directory/file conflict, etc.).
>
> I have ideas about how to resolve those tricky corner cases, but not
> about what the UI should look like. =C2=A0How does one go about addin=
g a
> directory? =C2=A0Does it ever get implicitly removed?

I suppose a special command for it is appropriate (git-keepdir?). Many
index-related commands are recursive by default and hard to change.

Yes I think it should be automatically removed from index when a file
is added inside tracked directories. Removing those files will also
remove the containing directory though.

> Would this actually require an index extension, strictly speaking?

Could it be done with an index extension? Interesting.

> Certainly one ought to register an extension name or bump the version
> number to avoid confusing gits that don't know about the feature.

Index extension with lowercase name are "necessary for correct
operation". Older git will abort on unknown required extensions. If
you add to the main part of the index, better bump version number.

> But after that, couldn't we (e.g.) allow the directory name (ending
> with '/') as index entry?

You could. You also need to strip '/' sometimes because certain part
of git does not expect '/' to be there (traverse_trees or
unpack_trees, I don't remember).
--=20
Duy
