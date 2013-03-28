From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Bug in "git rev-parse --verify"
Date: Thu, 28 Mar 2013 14:04:27 +0100
Message-ID: <51543FDB.9010109@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 14:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULCca-0001al-QN
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 14:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab3C1NLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 09:11:32 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:44180 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753572Ab3C1NLc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Mar 2013 09:11:32 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Mar 2013 09:11:31 EDT
X-AuditID: 12074412-b7f216d0000008d4-0a-51543fdd8012
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 04.5C.02260.DDF34515; Thu, 28 Mar 2013 09:04:29 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2SD4SRH020379
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 28 Mar 2013 09:04:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqHvXPiTQYN1UG4uuK91MDowenzfJ
	BTBGcdskJZaUBWem5+nbJXBnnDx8nK2gj7PiVh9fA+Nm9i5GTg4JAROJaZ3dLBC2mMSFe+vZ
	uhi5OIQELjNKNO++wwrhPGSSuL3wPVgVr4C2xKsv75hAbBYBVYnmH+fA4mwCuhKLeprB4qIC
	YRJ7L0xjg6gXlDg58wlYjQhQza5nV8HiwgIaEvfaFjOC2MwCOhLv+h4wQ9jyEtvfzmGewMg7
	C0n7LCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6aXm1mil5pSuokREkxCOxjX
	n5Q7xCjAwajEw9sgHhwoxJpYVlyZe4hRkoNJSZSXDxiKQnxJ+SmVGYnFGfFFpTmpxYcYJTiY
	lUR4J8sA5XhTEiurUovyYVLSHCxK4rw/F6v7CQmkJ5akZqemFqQWwWRlODiUJHjP2QE1Chal
	pqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIMiLL4YGGMgKR6gvY4gN/EWFyTmAkUhWk8x
	6nJ0Lfr8ilGIJS8/L1VKnHcTyA4BkKKM0jy4FbDU8YpRHOhjYd7rIFU8wLQDN+kV0BImoCXL
	vwaDLClJREhJNTDqV/KeSd2clM5y5aHb2X1HGQ7MqzryefW00DNfOq0/vj+3bF1ezwJXjrUd
	j/nKg64ZNM6SZtm3PuPv2r2m702vPwgLuf/UnjF3tW9wxVc76xA9noigw0X3Fws/rvgYwP6v
	tXOFSMGry/2J+Y6XY+dvWtxa06fTV6p5a/qHO2qazF9kX9+VcTRRYinOSDTUYi4q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219386>

On Junio's master, "git rev-parse --verify" accepts *any* 40-digit
hexadecimal number.  For example, pass it 40 "1" characters, and it
accepts the argument:

$ git rev-parse --verify 1111111111111111111111111111111111111111
1111111111111111111111111111111111111111
$ echo $?
0

Obviously, my repo doesn't have an object with this hash :-) so I think
this argument should be rejected.

If you add or remove a digit (to make the length different than 40), it
is correctly rejected:

$ git rev-parse --verify 111111111111111111111111111111111111111
fatal: Needed a single revision
$ echo $?
128

I believe that "git rev-parse --verify" is meant to verify that the
argument is an actual object, and that it should reject fictional SHA1s.
 (If not then the documentation should be clarified.)  The same problem
also exists in 1.8.2 but I haven't checked how much older it is.

The behavior presumably comes from the following clause in get_sha1_basic():

	if (len == 40 && !get_sha1_hex(str, sha1))
		return 0;

I won't have time to pursue this.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
