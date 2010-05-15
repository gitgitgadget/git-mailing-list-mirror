From: Clemens Buchacher <drizzd@aon.at>
Subject: [ANNOUNCE] diffit - A git plugin for vim
Date: Sat, 15 May 2010 12:50:09 +0200
Message-ID: <20100515105009.GA10517@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 15 12:55:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODF1L-0004hG-Vc
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 12:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468Ab0EOKuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 06:50:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48703 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab0EOKuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 06:50:21 -0400
Received: by fxm6 with SMTP id 6so2267493fxm.19
        for <git@vger.kernel.org>; Sat, 15 May 2010 03:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=8pTFb7YfzF42aiPEQySgbeQkUZz7pXDiNOqwMpsxCnA=;
        b=Hh1SpowQbz5Vl1w+NlqhfAwbJBkcH46oLfsskCi/y1yVfRJSUJJsclfX8ud3FT6CvN
         UIZzP9cTkdbRSmbjCv1l+sRH1l9mc05sTrzIljvqtfR+mHPqvjpJiI9rHUJs8UB9BDqY
         3IytBBMtYqPfhaK6gnz+Y6116vlZiONEbvFGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:bcc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        b=HXzec/Jv7a7jvAuUrBaCReS4NTEh9SHOrF8+42q8yrXNSbEgsGRR4L2FJT4Aby1yrK
         NKI3Eak+wAsSofDqWDiFxm+xvm/aVPXhLb1bLwMi1K+pjiiI2+QVswMewX3gbAjadSLw
         3WJKEORiOOP4/c+v7kJ9902fLz+MsVkRu45jQ=
Received: by 10.223.65.73 with SMTP id h9mr2974688fai.75.1273920616765;
        Sat, 15 May 2010 03:50:16 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id z12sm15334507fah.21.2010.05.15.03.50.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 03:50:15 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1ODEwb-0002nu-Mq; Sat, 15 May 2010 12:50:09 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147138>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I am currently working on a git plugin for vim. My aim is for it to imitate
much of git-gui's functionality. Right now, it is still closer to "add -p".

But I believe it's already useful. And since I'm new to vim scripting, it
can use some testing.

To install, copy diffit.vim (attached to this email) to
~/.vim/plugin/diffit.vim .

To toggle diffit mode, use <Leader>d, where <Leader> is '\' by default.

Control keys:

 <Leader>d      toggle diffit mode
 s              stage hunk
 d              skip file

I hope you like it. Have fun!

Clemens
---

You can clone diffit from here.

 git://repo.or.cz/diffit.git
 http://github.com/drizzd/diffit.git

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="diffit.vim"

" ============================================================================
" File:        diffit.vim
" Description: Show diff for current buffer
" Maintainer:  Clemens Buchacher <drizzd@aon.at>
" License:     GPLv2
"
" ============================================================================
if exists('loaded_diffit')
    finish
end
let loaded_diffit = 1

let s:diffit_version = '0'

"for line continuation - i.e dont want C in &cpo
let s:old_cpo = &cpo
set cpo&vim

map <silent> <Leader>d :call <SID>Diffit()<CR>

function s:Error(msg)
	echohl ErrorMsg
	echon 'diffit: ' . a:msg
	echohl None
endfunction

function s:Info(msg)
	echon 'diffit: ' . a:msg
endfunction

function s:Die(msg)
	call s:Error('fatal: ' . a:msg)
	throw "diffit"
endfunction

function s:System(...)
	let out = system(join(a:000))
	if v:shell_error
		call s:Die(a:0 . ' failed: ' . out)
	end
	return out
endfunction

function s:Header()
	let header = []
	for n in range(1, line('$'))
			let l = getline(n)
			if l =~ '^diff --git ' ||
						\l =~ '^diff --cc ' ||
						\l =~ '^diff --combined ' ||
						\l =~ '^old mode ' ||
						\l =~ '^new mode ' ||
						\l =~ '^--- ' ||
						\l =~ '^+++ '
				call add(header, l)
				continue
			end
			if l !~ '^index '
				break
			end
	endfor
	return [header, n - 1]
endfunction

function s:Exit()
	let view = b:view
	bdelete
	call winrestview(view)
endfunction

function s:Diffit()
	if exists('b:diffit') && b:diffit == 1
		call s:Exit()
		return
	end
	try
		call s:Diffit_init()
	catch /^diffit$/
		if exists('b:diffit') && b:diffit == 1
			call s:Exit()
		end
	endtry
endfunction

function s:Read_diff(pathlist)
	let diff = tempname()
	let path = ''
	for path in a:pathlist
		let out = s:System('git diff', '--', path, '>', diff)
		if getfsize(diff) > 0
			break
		end
	endfor
	return [diff, path]
endfunction

function s:Write_diff(diff, orig)
	setlocal modifiable
	silent 1,$delete _
	silent exe 'read ' . a:diff
	silent 1delete _
	setlocal nomodifiable

	if a:orig
		let orig_pos = b:view['lnum']
		let new_pos = s:Diffpos(orig_pos)
		let view = copy(b:view)
		let view['lnum'] = abs(new_pos)
		if new_pos > 0
			let view['topline'] += new_pos - orig_pos
			let view['topline'] = max([1, view['topline']])
		else
			let view['topline'] = -new_pos - 4
		end
		let view['curswant'] += 1
		let view['col'] += 1
		call winrestview(view)
	else
		call cursor(abs(s:Diffpos(0)), 1)
	end
endfunction

function s:Diffit_init()
	update
	let out = s:System('git rev-parse',  '--is-inside-work-tree')
	if v:shell_error == 128 || split(out)[0] != 'true'
		call s:Error('not inside work tree')
		return
	elseif v:shell_error
		call s:Error('git rev-parse failed: ' . out)
		return
	end
	let out = s:System('git diff', '--name-only')
	let pathlist = split(out, '\n')
	if empty(pathlist)
		call s:Info('no changes')
		return
	end
	let orig_path = bufname('%')
	let k = index(pathlist, orig_path)
	if k > 0
		call remove(pathlist, k)
		call insert(pathlist, orig_path, 0)
	end
	let [diff, path] = s:Read_diff(pathlist)
	let orig = path == orig_path
	if getfsize(diff) == 0
		call s:Info('no changes')
		return
	end

	let view = winsaveview()
	silent! exe 'edit ' . tempname()
	let b:pathlist = pathlist
	let b:view = view
	let b:diffit = 1
	setf git-diff
	setlocal noswapfile
	setlocal buftype=nofile
	setlocal nowrap
	setlocal foldcolumn=0
	setlocal nobuflisted

	iabc <buffer>

	nnoremap <silent> <buffer> s :call <SID>Stage_hunk(line('.'))<CR>
	nnoremap <silent> <buffer> d :call <SID>Next_diff()<CR>

	call s:Write_diff(diff, orig)
	echon '"' . path . '"'
endfunction

function s:Next_diff()
	call remove(b:pathlist, 0)
	let [diff, path] = s:Read_diff(b:pathlist)
	if getfsize(diff) > 0
		call s:Write_diff(diff, 0)
		echon '"' . path . '"'
	else
		call s:Exit()
	end
endfunction

function s:Diffpos(orig_pos)
	let diffpos = -1
	let hunk_start = 1
	let hunk_end = 1
	call cursor(1, 1)
	while search('^@@', 'W') > 0
		let [start, length] = matchlist(getline('.'),
			\'^@@ -[0-9]*,[0-9]* +\%(\([0-9]*\),\)\?\([0-9]*\)')[1:2]
		if empty(start)
			let start = 1
		end
		if diffpos < 0
			let diffpos = -line('.')
		end
		if start > a:orig_pos
			break
		end
		let diffpos = line('.')
		let hunk_start = start
		let hunk_end = hunk_start + length - 1
	endwhile
	if diffpos < 0
		return diffpos
	end
	let pos = hunk_start - 1
	let target_pos = min([a:orig_pos, hunk_end])
	while diffpos < line('$')
		if getline(diffpos) =~ '^-'
			let diffpos += 1
			continue
		end
		if pos >= target_pos
			break
		end
		let diffpos += 1
		let pos += 1
	endwhile

	if getline(diffpos) =~ '^-'
		return -last
	else
		return diffpos
	end
endfunction

function s:Stage_hunk(pos)
	call cursor(a:pos, 1)
	let h_start = search('^@@', 'bcW')
	if h_start == 0
		return
	end
	call cursor(h_start, 1)
	let h_end = search('^@@', 'nW')-1
	if h_end < 0
		let h_end = line('$')
	end
	let h_range = h_start . ',' . h_end

	let [patch, header_end] = s:Header()
	call extend(patch, getline(h_start, h_end))
	let patchfile = tempname()
	call writefile(patch, patchfile)
	let out = s:System('git apply', '--cached', '--whitespace=nowarn', patchfile)

	setlocal modifiable
	silent exe h_range . 'delete _'
	setlocal nomodifiable
	if line('$') == header_end
		call s:Next_diff()
		return
	end
endfunction

let &cpo = s:old_cpo

--pWyiEgJYm5f9v55/--
