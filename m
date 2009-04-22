From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Re: [JGIT PATCH/RFC] Removed possibility to change stderr for ssh 
	sessions
Date: Wed, 22 Apr 2009 19:55:50 +0400
Message-ID: <85647ef50904220855g62890de0r4fee4ea8503aa348@mail.gmail.com>
References: <85647ef50904211149lc4a4902h554c973017d87adb@mail.gmail.com>
	 <20090422154657.GK23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 17:57:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwepD-0005dW-V8
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 17:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283AbZDVPzx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 11:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754112AbZDVPzx
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 11:55:53 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:56306 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbZDVPzw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 11:55:52 -0400
Received: by bwz7 with SMTP id 7so37129bwz.37
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m/iuhOpjhMl8Sg5sfDuNd/W6Z56iwPp/fzROZ3WrAHw=;
        b=jFJZMDvdjXReG9ECItFjlC+Wl5xz/ZklPDd0NxRXicVzc302tBrlRY2zx55RJUSxaU
         2WsREqfnGNLaOnXWwLlbjKzgUHnupgAndJcrdqCbFP6NIFuZeTLWFl+HEa7XzYZnXv+S
         JiScEL3snweVF8vD2eruN0iFArrm6JIj2oWDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T1/nq27UpPkmfLpB49M9MnisNy5UkPBYlsxpLlcIkzmjRsXEAIUjcolVr516mF8oJB
         VjTFfae7+jsblPp0BvUdMWOw1ziFsionDJJrlJxQF6fSVqA7z9X59XIq/H5djGiN61/X
         24Lcx8aBIcBBoP100H8jKBgUlHqCO8DhOKopQ=
Received: by 10.204.53.72 with SMTP id l8mr7781624bkg.171.1240415750208; Wed, 
	22 Apr 2009 08:55:50 -0700 (PDT)
In-Reply-To: <20090422154657.GK23604@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117211>

On Wed, Apr 22, 2009 at 7:46 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
>> The current implementation allowed to change stderr for the
>> ssh sessions. However this functionality is broken.
>
> Good catch.
>
> I applied this, but two comments.
>
> One, your patch was line wrapped, I had to manually unwrap it
> to apply. =A0So your MUA is still not able to send patches right.
> Thought you'd like to know.
>
It looks like both gmail and thunderbird both have a problem. I will
look how opera works next time.

> Two,
>
>> + =A0 =A0 =A0* The method does not have to be implemented and will b=
e removed in
>> future versions.
>> =A0 =A0 =A0 =A0*
>> =A0 =A0 =A0 =A0* @return an OutputStream to receive the SSH error st=
ream.
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 public abstract OutputStream getErrorStream();
>> + =A0 =A0 @Deprecated
>> + =A0 =A0 public OutputStream getErrorStream() {
>> + =A0 =A0 =A0 =A0 =A0 =A0 throw new UnsupportedOperationException("T=
his method should not be called.");
>> + =A0 =A0 }
>> =A0}
>
> I think deprecation here is silly. =A0I just deleted the method.
>
> Nobody should be calling this except TransportGitSsh, as you
> discovered.
>
> If they are, getting UnsupportedOperationException at runtime is
> as bad as NoSuchMethodError at runtime, and either is a lot less
> friendly than a no such method error at compile time.
>
> Given the method is being broken, I'd rather just remove it outright.
> So I removed it from your patch when I applied it.
>
No problem with it. I have left it for the the case if someone
overrides it with @Override annotation. Deprecation would have given a
warning rather then an error on annotation.

Constantine
