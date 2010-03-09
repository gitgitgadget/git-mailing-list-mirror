From: BJ Hargrave <bj@bjhargrave.com>
Subject: Re: git-http-backend and Authenticated Pushes
Date: Tue, 9 Mar 2010 14:17:43 -0500
Message-ID: <64E1366D-31FC-4E0D-9F7D-35E6387E2EC1@bjhargrave.com>
References: <46a47f951003090908s62512bd7xcbb707205958e004@mail.gmail.com> <2b8265361003091101x1e3a3410hc3be2446dc7ddce@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ryan Phillips <ryan@trolocsis.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?Antonio_Garc=EDa_Dom=EDnguez?= <nyoescape@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 20:18:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np4we-00049I-IX
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 20:18:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab0CITR5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Mar 2010 14:17:57 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63603 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755820Ab0CITR4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Mar 2010 14:17:56 -0500
Received: by gyd8 with SMTP id 8so114072gyd.19
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 11:17:55 -0800 (PST)
Received: by 10.101.129.13 with SMTP id g13mr469844ann.30.1268162269404;
        Tue, 09 Mar 2010 11:17:49 -0800 (PST)
Received: from hargrave.hargrave.local (125.69.205.68.cfl.res.rr.com [68.205.69.125])
        by mx.google.com with ESMTPS id 9sm2315079ywf.8.2010.03.09.11.17.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 11:17:46 -0800 (PST)
In-Reply-To: <2b8265361003091101x1e3a3410hc3be2446dc7ddce@mail.gmail.com>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141841>

On Mar 9, 2010, at 14:01 , Antonio Garc=EDa Dom=EDnguez wrote:

> Git first GETs that URL you mention, and then POSTs to the usual
> git-receive-pack URL. Both need authentication, but you're only
> authenticating the POST. I suggest you authenticate every request to
> the git-receive-pack service. Try something like this (warning,
> untested!):
>=20
>>       <LocationMatch "^/git/.*/[^/]*git-receive-pack$"

LocationMatch will not match against the query string which is where th=
e service name is. To match against the query string, you would need to=
 do something like:

	RewriteCond %{QUERY_STRING} service=3Dgit-receive-pack
	RewriteRule .* - [E=3DAUTHREQUIRED:yes]
then
	Order Allow,Deny
	Deny from env=3DAUTHREQUIRED
	Allow from all
	Satisfy Any
	# Add other auth statements for password file.

(also untested :-)

But, I would think using <LimitExcept GET PROPFIND OPTIONS REPORT> to p=
rotect against "writing" to the repo without auth should be sufficient.
--=20

BJ Hargrave
