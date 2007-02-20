From: Matthias Lederhofer <matled@gmx.net>
Subject: [BUG] diff -B does not (always?) use colors
Date: Tue, 20 Feb 2007 11:08:46 +0100
Message-ID: <20070220100846.GA7928@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 11:08:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJRva-0008Ov-GS
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 11:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816AbXBTKIv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 05:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932809AbXBTKIv
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 05:08:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:60382 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932816AbXBTKIu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 05:08:50 -0500
Received: (qmail invoked by alias); 20 Feb 2007 10:08:49 -0000
X-Provags-ID: V01U2FsdGVkX1+DUDUTBAmDNKYNV3FWUfFzHruIrWF1qcJVoIJr8H
	/dWA==
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40225>

I found that git diff -B does not always use colors and I don't have
time to figure out what it is atm.

The bug can be triggered by this two files and running git diff with
-B.  You can also just clone the repository from
git://igit.ath.cx/~matled/tmp/break/

% git cat-file -p HEAD~1:test
def test(p)
    if p
        Array.new
        Array.new(2)
        Array.new(5, "A")

        # only one copy of the object is created
        a = Array.new(2, Hash.new)
        a[0]['cat'] = 'feline'
        a
        a[1]['cat'] = 'Felix'
        a

        # here multiple copies are created
        a = Array.new(2) { Hash.new }
        a[0]['cat'] = 'feline'
        a

        squares = Array.new(5) {|i| i*i}
        squares

        copy = Array.new(squares)
    end
end
% git cat-file -p HEAD:test  
def test(p)
    test_bla if p
end

def test_bla
    Array.new
    Array.new(2)
    Array.new(5, "A")

    # only one copy of the object is created
    a = Array.new(2, Hash.new)
    a[0]['cat'] = 'feline'
    a
    a[1]['cat'] = 'Felix'
    a

    # here multiple copies are created
    a = Array.new(2) { Hash.new }
    a[0]['cat'] = 'feline'
    a

    squares = Array.new(5) {|i| i*i}
    squares

    copy = Array.new(squares)
end
