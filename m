From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT PATCH 02/11] Use Set instead of array to keep track of
 change listeners
Date: Thu, 05 Feb 2009 17:36:43 +0100
Message-ID: <498B159B.4040001@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com> <1233795618-20249-2-git-send-email-torarnv@gmail.com> <1233795618-20249-3-git-send-email-torarnv@gmail.com> <20090205154815.GG26880@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 17:38:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV7FG-0006Ui-0K
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 17:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299AbZBEQgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 11:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755112AbZBEQgt
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 11:36:49 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:16759 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbZBEQgs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 11:36:48 -0500
Received: by fg-out-1718.google.com with SMTP id 16so225996fgg.17
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 08:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=AKyzqX6t0GmB2cAkM9GbgjUzLhLjBOqbvMnLTOqw0wc=;
        b=TmZuphvX7SkVZmz8eojlssuIAOqhlKeaoMDn9aUUjKY3O/ebWlpki+YEZ6sp5y7oKx
         7a1xs8XI6fRuPlf8Xz6Py9NzxjppTApR0bBah/AEBR/zuKmNXYgOjBYhglXf7CZNceQk
         4Qc6fHsFerJHTu1hge4Jqitz2csWgoZmoy8mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=oYchafIQC3n3OoGov09XuImQk2HwIBldGmQU0WOvDcGOyxQUeN0vtim4Vgd7Tkoiz8
         h6P2UHckE9uzDUe3F9rdR9URRiAqPeHuZ1DY90JNbJjbuypmGq/CSpIvoTkqu4J5aAlU
         dxbvjsq2zvGPjPY8Nfcbnixv9xzMX4KMEnw0k=
Received: by 10.86.99.9 with SMTP id w9mr428786fgb.68.1233851806663;
        Thu, 05 Feb 2009 08:36:46 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id e11sm1237252fga.40.2009.02.05.08.36.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Feb 2009 08:36:46 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090205154815.GG26880@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108579>

Shawn O. Pearce wrote:
> Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
>> +	public static synchronized void removeRepositoryChangeListener(
>> +			final RepositoryChangeListener objectThatCares) {
>> +		repositoryChangeListeners.remove(objectThatCares);
>>  	}
>> =20
>>  	/**
>> @@ -131,13 +133,8 @@ public static synchronized void addRepositoryCh=
angeListener(
>>  	 *            the repository which has had changes occur within it=
=2E
>>  	 */
>>  	static void fireRepositoryChanged(final RepositoryMapping which) {
>> -		final RepositoryChangeListener[] e =3D getRepositoryChangeListene=
rs();
>> -		for (int k =3D e.length - 1; k >=3D 0; k--)
>> -			e[k].repositoryChanged(which);
>> -	}
>> -
>> -	private static synchronized RepositoryChangeListener[] getReposito=
ryChangeListeners() {
>> -		return repositoryChangeListeners;
>> +		for (RepositoryChangeListener listener : repositoryChangeListener=
s)
>> +			listener.repositoryChanged(which);
>=20
> See anything wrong here, like that the Set can be modified while
> GitProjectData's class lock is held, but its being read here without
> any locking?

You're perfectly right. New patch coming up!

Tor Arne
